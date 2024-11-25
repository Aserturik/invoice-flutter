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
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.green,
      //   child: const Icon(Icons.add),
      //   onPressed: () async {
      //     await ref.read(appProvider.notifier).sales(
      //           sales: productsSelected,
      //         );
      //   },
      // ),
      appBar: AppBar(
        backgroundColor: SsColors.orange,
        title: const Text('Ventas'),
      ),
      body: Column(
          children: widget.saleDetails
              .map((e) => Container(
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    )),
                    child: Column(
                      children: [
                        Text(e.productName),
                        Text(e.quantity.toString()),
                        Text(e.productBarCode.toString()),
                        Text(e.unitPrice.toMoney()),
                        Text(e.total.toMoney()),
                      ],
                    ),
                  ))
              .toList()),
    );
  }
}
