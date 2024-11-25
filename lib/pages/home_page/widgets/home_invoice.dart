import 'package:facturacion/models/sale_model.dart';
import 'package:facturacion/pages/home_page/home_provider.dart';
import 'package:facturacion/routes/app_router.dart';
import 'package:facturacion/routes/app_router.gr.dart';
import 'package:facturacion/utils/date_extension.dart';
import 'package:facturacion/utils/double_extension.dart';
import 'package:facturacion/widgets/ss_card.dart';
import 'package:facturacion/widgets/ss_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeInvoice extends ConsumerStatefulWidget {
  const HomeInvoice({
    super.key,
  });

  @override
  ConsumerState<HomeInvoice> createState() => _HomeProductsState();
}

class _HomeProductsState extends ConsumerState<HomeInvoice> {
  @override
  Widget build(BuildContext context) {
    final List<SaleModel>? sales = ref.watch(homeProvider).sales;
    final bool loading = ref.watch(homeProvider).loadingClients;
    return loading
        ? const Center(child: CircularProgressIndicator())
        : SsListView(
            onRefresh: () {
              return ref.read(homeProvider.notifier).fetchDataClients();
            },
            itemCount: sales?.length ?? 0,
            itemBuilder: (context, index) {
              final date = DateTime.parse(sales![index].saleDate);
              return InkWell(
                onTap: () async {
                  appRouter.push(
                      SaleDetailsRoute(saleDetails: sales[index].details));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SsCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: [
                            Text(
                              sales[index].id.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(date.toFormattedString()),
                                Text(sales[index].paymentMethod),
                              ],
                            ),
                          ],
                        ),
                        Text(sales[index].total.toMoney()),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
