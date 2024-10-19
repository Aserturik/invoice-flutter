import 'package:auto_route/auto_route.dart';
import 'package:facturacion/widgets/ss_button.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProductEditPage extends StatelessWidget {
  const ProductEditPage({super.key});

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
            const Text('Nombre del producto'),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nombre',
              ),
            ),
            const SizedBox(height: 10),
            const Text('Cantidad producto'),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cantidad',
              ),
            ),
            const SizedBox(height: 10),
            const Text('description del producto'),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'description',
              ),
            ),
            const SizedBox(height: 10),
            const Text('Precio del producto'),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Precio',
              ),
            ),
            const SizedBox(height: 20),
            SsButton(
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
