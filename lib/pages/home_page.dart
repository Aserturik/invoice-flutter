import 'package:auto_route/auto_route.dart';
import 'package:facturacion/models/product_model.dart';
import 'package:facturacion/pages/app_provider.dart';
import 'package:facturacion/routes/app_router.dart';
import 'package:facturacion/routes/app_router.gr.dart';
import 'package:facturacion/widgets/ss_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String scann = 'non';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.read(appProvider.notifier).fetchData();
    });
  }

  Future<void> scanBarCode({loading = true}) async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
      "#ff6666",
      "Cancel",
      true,
      ScanMode.BARCODE,
    )?.listen((barcode) {
      print(barcode);
      setState(() {
        scann = barcode;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<ProductModel?>? products = ref.watch(appProvider).products;
    final bool loading = ref.watch(appProvider).loadingHome;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(scann /* 'HOME' */),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              switch (value) {
                case 'Añadir nuevo producto':
                  // appRouter.push(const ProductAddRoute());
                  await scanBarCode();
                  break;
                case 'Crear factura':
                  // appRouter.push(const SaleRoute());
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
                            Text(product!.barCode),
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
            ),
    );
  }
}
