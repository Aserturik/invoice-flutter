import 'package:auto_route/auto_route.dart';
import 'package:facturacion/models/product_model.dart';
import 'package:facturacion/pages/app_provider.dart';
import 'package:facturacion/routes/app_router.dart';
import 'package:facturacion/widgets/ss_alert.dart';
import 'package:facturacion/widgets/ss_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ProductEditPage extends ConsumerStatefulWidget {
  final ProductModel? product;
  const ProductEditPage({required this.product, super.key});

  @override
  ConsumerState<ProductEditPage> createState() => _ProductEditPageState();
}

class _ProductEditPageState extends ConsumerState<ProductEditPage> {
  final TextEditingController _barCodeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _purchasePriceController =
      TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  bool loading = false;
  @override
  void initState() {
    super.initState();
    if (widget.product == null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        ref.read(appProvider.notifier).fetchData();
      });
    }
    _barCodeController.text = widget.product!.barCode;
    _nameController.text = widget.product!.name;
    _priceController.text = widget.product!.salePrice.toString();
    _purchasePriceController.text = widget.product!.purchasePrice.toString();
    _urlController.text = widget.product!.urlImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(238, 106, 34, 1),
        title: const Text('Editar producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
            const SizedBox(height: 10),
            const Text('Precio del venta'),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'venta',
              ),
              controller: _priceController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
            ),
            const SizedBox(height: 10),
            const Text('Url de la imagen'),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Url',
              ),
              controller: _urlController,
            ),
            const SizedBox(height: 10),
            const Text('Precio del costo'),
            TextField(
              enabled: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'costo',
              ),
              controller: _purchasePriceController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
            ),
            const SizedBox(height: 10),
            const Text('Cantidad producto'),
            TextField(
              enabled: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cantidad',
              ),
              controller:
                  TextEditingController(text: widget.product!.stock.toString()),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const SizedBox(height: 20),
            SsButton(
              loading: loading,
              onPressed: () async {
                if (_barCodeController.text.isEmpty ||
                    _nameController.text.isEmpty ||
                    _priceController.text.isEmpty ||
                    _urlController.text.isEmpty) {
                  SsAlert.showAutoDismissSnackbar(
                    context,
                    Colors.red,
                    'Todos los campos son requeridos',
                  );
                }
                setState(() {
                  loading = true;
                });
                await ref.read(appProvider.notifier).updateProduct(
                      id: widget.product!.id,
                      barcode: _barCodeController.text,
                      name: _nameController.text,
                      salePrice: double.parse(_priceController.text),
                      purchasePrice:
                          double.parse(_purchasePriceController.text),
                      urlImage: _urlController.text,
                    );
                setState(() {
                  loading = false;
                });
                appRouter.back();
                await ref.read(appProvider.notifier).fetchData();
              },
              text: 'Actualizar',
              backgroundColor: const Color.fromRGBO(238, 106, 34, 1),
            )
          ],
        ),
      ),
    );
  }
}
