import 'package:auto_route/auto_route.dart';
import 'package:facturacion/models/product_model.dart';
import 'package:facturacion/pages/app_provider.dart';
import 'package:facturacion/routes/app_router.dart';
import 'package:facturacion/routes/app_router.gr.dart';
import 'package:facturacion/widgets/ss_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
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
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('HOME'),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'Añadir nuevo producto':
                    print('1');
                    appRouter.push(const ProductAddRoute());
                    break;
                  case 'Modificar producto':
                    print('2');
                    break;
                  case 'Crear factura':
                    appRouter.push(const SaleRoute());
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: 'Añadir nuevo producto',
                    child: Text('Añadir nuevo producto'),
                  ),
                  const PopupMenuItem(
                    value: 'Modificar producto',
                    child: Text('Modificar producto'),
                  ),
                  const PopupMenuItem(
                    value: 'Crear factura',
                    child: Text('Crear factura'),
                  ),
                ];
              },
            ),
          ],
        ),
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemBuilder: (context, index) {
                  final product = products![index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        appRouter.push(ProductEditRoute(product: product));
                      },
                      child: SsCard(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(product.barCode),
                              Text(product.name),
                              Text(product.salePrice.toString()),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: products?.length ?? 0,
              ));
  }
}
