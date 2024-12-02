import 'package:auto_route/auto_route.dart';
import 'package:facturacion/models/sale_details_model.dart';
import 'package:facturacion/utils/double_extension.dart';
import 'package:facturacion/widgets/ss_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class SaleDetailsPage extends ConsumerStatefulWidget {
  final List<SaleDetailsModel> saleDetails;
  const SaleDetailsPage({
    required this.saleDetails,
    super.key,
  });

  @override
  ConsumerState<SaleDetailsPage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<SaleDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: SsColors.orange,
        title: const Text('Detalles de venta'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: widget.saleDetails
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            decoration: const BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(e.productName),
                                    Text(e.productBarCode.toString()),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Cantiadad: ${e.quantity.toString()}'),
                                    Text(
                                        'Precio unitario: ${e.unitPrice.toMoney()}'),
                                    Text('Total venta: ${e.total.toMoney()}'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList()),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total venta: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  widget.saleDetails.isEmpty
                      ? 0.0.toMoney()
                      : widget.saleDetails
                          .map((e) => e.total)
                          .reduce((value, element) => value + element)
                          .toMoney(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
