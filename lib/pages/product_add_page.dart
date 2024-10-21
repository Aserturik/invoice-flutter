import 'package:auto_route/auto_route.dart';
import 'package:facturacion/pages/app_provider.dart';
import 'package:facturacion/widgets/ss_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ProductAddPage extends ConsumerStatefulWidget {
  const ProductAddPage({super.key});

  @override
  ConsumerState<ProductAddPage> createState() => _ProductAddPageState();
}

class _ProductAddPageState extends ConsumerState<ProductAddPage> {
  final TextEditingController _barCodeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(appProvider).loadingHome;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('AÑADIR NUEVO PRODUCTO'),
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
            const Text('Cantidad producto'),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cantidad',
              ),
              controller: _stockController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const SizedBox(height: 10),
            const Text('Precio del producto'),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Precio',
              ),
              controller: _priceController,
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
                      barcode: _barCodeController.text,
                      name: _nameController.text,
                      stock: int.parse(_stockController.text),
                      description: _descriptionController.text,
                      price: double.parse(_priceController.text),
                    );
              },
              text: 'Añadir',
              backgroundColor: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}
