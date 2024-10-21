import 'package:auto_route/auto_route.dart';
import 'package:facturacion/models/product_model.dart';
import 'package:facturacion/pages/app_provider.dart';
import 'package:facturacion/widgets/ss_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class SalePage extends ConsumerStatefulWidget {
  const SalePage({super.key});

  @override
  ConsumerState<SalePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<SalePage> {
  final List<ProductModel> productsSelected = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.read(appProvider.notifier).fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<ProductModel>? products = ref.watch(appProvider).products;
    final bool loading = ref.watch(appProvider).loadingHome;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
          onPressed: () {
            if (productsSelected.isNotEmpty) {
              // appRouter.push(SaleListRoute(productsSelected: productsSelected));
            }
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('VENTAS'),
        ),
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemBuilder: (context, index) {
                  final product = products![index];
                  bool isSelected = productsSelected.contains(product);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SsCard(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(product.barCode),
                            Text(product.name),
                            Text(product.salePrice.toString()),
                            SizedBox(
                              width: 50,
                              child: Expanded(
                                child: TextField(
                                  onChanged: (value) {},
                                  enabled: isSelected,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Cantidad',
                                  ),
                                  controller: TextEditingController(text: '1'),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                            ),
                            Checkbox(
                              value: isSelected,
                              onChanged: (value) {
                                if (value == true) {
                                  productsSelected.add(product);
                                } else {
                                  productsSelected.remove(product);
                                }
                                setState(() {});
                                // print(products);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: products?.length ?? 0,
              ));
  }
}
