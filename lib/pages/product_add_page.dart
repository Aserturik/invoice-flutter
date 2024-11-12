import 'package:auto_route/auto_route.dart';
import 'package:facturacion/pages/app_provider.dart';
import 'package:facturacion/routes/app_router.dart';
import 'package:facturacion/widgets/ss_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ProductAddPage extends ConsumerStatefulWidget {
  final String? barcode;
  const ProductAddPage({
    this.barcode,
    super.key,
  });

  @override
  ConsumerState<ProductAddPage> createState() => _ProductAddPageState();
}

class _ProductAddPageState extends ConsumerState<ProductAddPage> {
  final TextEditingController _barCodeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _purchasePriceController =
      TextEditingController();
  final TextEditingController _salePriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _barCodeController.text = widget.barcode ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(appProvider).loadingHome;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(238, 106, 34, 1),
        title: const Text('AÑADIR NUEVO PRODUCTO'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text('BarCode del producto'),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'BarCode',
                ),
                controller: _barCodeController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              const SizedBox(height: 10),
              const Text('Nombre del producto'),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre',
                ),
                controller: _nameController,
                keyboardType: TextInputType.text,
              ),
              // const SizedBox(height: 10),
              // const Text('Cantidad producto'),
              // TextField(
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: 'Cantidad',
              //   ),
              //   controller: _stockController,
              //   keyboardType: TextInputType.number,
              //   inputFormatters: [
              //     FilteringTextInputFormatter.digitsOnly,
              //   ],
              // ),
              const SizedBox(height: 10),
              const Text('Precio del producto'),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Precio de venta',
                ),
                controller: _salePriceController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
              ),
              const SizedBox(height: 10),
              const Text('Precio del producto'),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Precio de compra',
                ),
                controller: _purchasePriceController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
              ),
              const SizedBox(height: 20),
              SsButton(
                loading: loading,
                enable: !loading,
                onPressed: () async {
                  await ref.read(appProvider.notifier).addProduct(
                        context: context,
                        barcode: _barCodeController.text,
                        name: _nameController.text,
                        purchasePrice:
                            double.parse(_purchasePriceController.text),
                        salePrice: double.parse(_salePriceController.text),
                        // stock: int.parse(_stockController.text),
                      );
                  appRouter.back();
                  await ref.read(appProvider.notifier).fetchData();
                },
                text: 'Añadir',
                backgroundColor: const Color.fromRGBO(238, 106, 34, 1),
              )
            ],
          ),
        ),
      ),
    );
  }
}
