import 'package:auto_route/auto_route.dart';
import 'package:facturacion/routes/app_router.dart';
import 'package:facturacion/routes/app_router.gr.dart';
import 'package:facturacion/widgets/ss_card.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                    appRouter.push(const ProductEditRoute());
                    break;
                  case 'Crear factura':
                    // appRouter.push(InvoiceRoute());
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
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SsCard(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(index.toString()),
                      const Text('Product'),
                      const Text('\$200.000'),
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: 100,
        ));
  }
}
