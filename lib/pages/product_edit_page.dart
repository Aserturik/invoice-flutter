import 'package:auto_route/auto_route.dart';
import 'package:facturacion/models/product_model.dart';
import 'package:facturacion/widgets/ss_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@RoutePage()
class ProductEditPage extends StatelessWidget {
  final ProductModel product;
  const ProductEditPage({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('EDITAR PRODUCTO'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text('BarCode del producto'),
            TextField(
              enabled: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'BarCode',
              ),
              controller: TextEditingController(text: product.barCode),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const SizedBox(height: 10),
            const Text('Nombre del producto'),
            TextField(
              enabled: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nombre',
              ),
              controller: TextEditingController(text: product.name),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            const Text('Cantidad producto'),
            TextField(
              enabled: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cantidad',
              ),
              controller: TextEditingController(text: product.stock.toString()),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const SizedBox(height: 10),
            const Text('Precio del producto'),
            TextField(
              enabled: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Precio',
              ),
              controller:
                  TextEditingController(text: product.salePrice.toString()),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
            ),
            const SizedBox(height: 20),
            SsButton(
              enable: false,
              onPressed: () {},
              text: 'Añadir',
              backgroundColor: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}
