import 'package:auto_route/auto_route.dart';
import 'package:facturacion/models/product_model.dart';
import 'package:facturacion/pages/app_provider.dart';
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
  @override
  void initState() {
    super.initState();
    if (widget.product == null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        ref.read(appProvider.notifier).fetchData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(238, 106, 34, 1),
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
              controller: TextEditingController(text: widget.product!.barCode),
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
              controller: TextEditingController(text: widget.product!.name),
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
              controller:
                  TextEditingController(text: widget.product!.stock.toString()),
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
              controller: TextEditingController(
                  text: widget.product!.salePrice.toString()),
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
              backgroundColor: const Color.fromRGBO(238, 106, 34, 1),
            )
          ],
        ),
      ),
    );
  }
}
