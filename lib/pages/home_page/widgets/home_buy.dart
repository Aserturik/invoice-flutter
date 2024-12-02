import 'package:facturacion/models/buy_model.dart';
import 'package:facturacion/pages/home_page/home_provider.dart';
import 'package:facturacion/routes/app_router.dart';
import 'package:facturacion/routes/app_router.gr.dart';
import 'package:facturacion/utils/date_extension.dart';
import 'package:facturacion/utils/double_extension.dart';
import 'package:facturacion/widgets/ss_card.dart';
import 'package:facturacion/widgets/ss_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeBuy extends ConsumerStatefulWidget {
  const HomeBuy({
    super.key,
  });

  @override
  ConsumerState<HomeBuy> createState() => _HomeProductsState();
}

class _HomeProductsState extends ConsumerState<HomeBuy> {
  @override
  Widget build(BuildContext context) {
    final List<BuyModel>? buys = ref.watch(homeProvider).buys;
    final bool loading = ref.watch(homeProvider).loadingClients;
    return loading
        ? const Center(child: CircularProgressIndicator())
        : SsListView(
            onRefresh: () {
              return ref.read(homeProvider.notifier).fetchDataClients();
            },
            itemCount: buys?.length ?? 0,
            itemBuilder: (context, index) {
              final date = buys![index].purchaseDate;
              return InkWell(
                onTap: () async {
                  appRouter.push(
                      PurchaseRoute(saleDetails: buys[index].purchaseDetails));
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
                              buys[index].id.toString(),
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
                                Text(buys[index].purchaseNumber),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(buys[index].total.toMoney()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
