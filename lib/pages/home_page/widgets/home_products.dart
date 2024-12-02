import 'package:facturacion/models/product_model.dart';
import 'package:facturacion/pages/app_provider.dart';
import 'package:facturacion/routes/app_router.dart';
import 'package:facturacion/routes/app_router.gr.dart';
import 'package:facturacion/utils/double_extension.dart';
import 'package:facturacion/widgets/ss_card.dart';
import 'package:facturacion/widgets/ss_colors.dart';
import 'package:facturacion/widgets/ss_image.dart';
import 'package:facturacion/widgets/ss_list_view.dart';
import 'package:facturacion/widgets/ss_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeProducts extends ConsumerStatefulWidget {
  const HomeProducts({
    super.key,
  });

  @override
  ConsumerState<HomeProducts> createState() => _HomeProductsState();
}

class _HomeProductsState extends ConsumerState<HomeProducts> {
  final TextEditingController _searchController = TextEditingController();
  Future<void> scanBarCode({loading = true}) async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
      "#ff6666",
      "Cancel",
      true,
      ScanMode.BARCODE,
    )?.listen((barcode) async {
      final product =
          await ref.read(appProvider.notifier).searchProduct(barcode);
      if (product != null) {
        appRouter.push(ProductEditRoute(product: product));
      } else {
        appRouter.push(ProductAddRoute(barcode: barcode));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool loading = ref.watch(appProvider).loadingHome;
    final List<ProductModel?>? productsTmp = ref.watch(appProvider).products;
    final List<ProductModel?>? products = productsTmp?.where((element) {
      if (_searchController.text.isEmpty) {
        return true;
      }
      return element!.name
          .toLowerCase()
          .contains(_searchController.text.toLowerCase());
    }).toList();
    return loading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SsTextfield(
                  controller: _searchController,
                  labelText: 'Buscar producto',
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: SsListView(
                  onRefresh: () {
                    return ref.read(appProvider.notifier).fetchData();
                  },
                  itemBuilder: (context, index) {
                    final productOne = products![index * 2];
                    ProductModel? productTwo;
                    if (index * 2 + 1 < products.length) {
                      productTwo = products[index * 2 + 1];
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                appRouter.push(
                                    ProductEditRoute(product: productOne));
                              },
                              child: _ViewProduct(
                                product: productOne,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          if (productTwo != null)
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  appRouter.push(
                                      ProductEditRoute(product: productTwo));
                                },
                                child: _ViewProduct(
                                  product: productTwo,
                                ),
                              ),
                            )
                          else
                            Expanded(
                              child: Container(),
                            ),
                        ],
                      ),
                    );
                  },
                  itemCount: ((products?.length ?? 0) / 2).ceil(),
                ),
              ),
            ],
          );
  }
}

class _ViewProduct extends StatelessWidget {
  const _ViewProduct({
    required this.product,
  });

  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    return SsCard(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
        ),
      ],
      padding: const EdgeInsets.all(0),
      boderColor: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: SsImage(
                height: 150,
                width: double.infinity,
                imageUrl: product?.urlImage ?? '',
                fit: BoxFit.contain,
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  color: SsColors.orange.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    Text(
                      product!.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      product!.salePrice.toMoney(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      product!.barCode,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
