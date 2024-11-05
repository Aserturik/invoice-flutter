import 'package:auto_route/auto_route.dart';
import 'package:facturacion/models/product_model.dart';
import 'package:facturacion/pages/app_provider.dart';
import 'package:facturacion/widgets/ss_button.dart';
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
  ProductModel? productSelected;
  final TextEditingController _search = TextEditingController();
  final TextEditingController _stock = TextEditingController();
  List<SaleModel> productsSelected = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.read(appProvider.notifier).fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool loading = ref.watch(appProvider).loadingHome;
    final List<ProductModel> products = ref.watch(appProvider).products ?? [];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () async {
          await ref.read(appProvider.notifier).sales(
                sales: productsSelected,
              );
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('VENTAS'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged: (value) {
                    try {
                      productSelected = products.firstWhere(
                        (element) =>
                            element.barCode.contains(value) ||
                            element.name.contains(value),
                      );
                    } catch (e) {
                      productSelected = null;
                    }
                    print(value);
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'BarCode',
                  ),
                  controller: _search,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                if (productSelected != null) ...[
                  SsCard(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(productSelected!.barCode),
                        Text(productSelected!.name),
                        Text(productSelected!.salePrice.toString()),
                        SizedBox(
                          width: 80,
                          child: Expanded(
                            child: TextField(
                              onChanged: (value) {},
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Cantidad',
                              ),
                              controller: _stock,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SsButton(
                    text: 'Añadir',
                    onPressed: () async {
                      productsSelected.add(
                        SaleModel(
                          idProduct: productSelected!.id,
                          quantity: int.parse(_stock.text),
                          unitPrice: productSelected!.salePrice,
                        ),
                      );
                    },
                  )
                ]
              ],
            ),
    );
  }
}
