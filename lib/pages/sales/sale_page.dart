import 'package:auto_route/auto_route.dart';
import 'package:facturacion/models/client_model.dart';
import 'package:facturacion/models/product_model.dart';
import 'package:facturacion/pages/app_provider.dart';
import 'package:facturacion/pages/home_page/home_provider.dart';
import 'package:facturacion/utils/double_extension.dart';
import 'package:facturacion/widgets/ss_alert.dart';
import 'package:facturacion/widgets/ss_button.dart';
import 'package:facturacion/widgets/ss_card.dart';
import 'package:facturacion/widgets/ss_colors.dart';
import 'package:facturacion/widgets/ss_dropdown.dart';
import 'package:facturacion/widgets/ss_list_view.dart';
import 'package:facturacion/widgets/ss_tabs.dart';
import 'package:facturacion/widgets/ss_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class SalePage extends ConsumerStatefulWidget {
  const SalePage({super.key});

  @override
  ConsumerState<SalePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<SalePage> {
  ProductModel? productSelected;
  final TextEditingController _search = TextEditingController();
  final TextEditingController _stock = TextEditingController(text: '1');
  bool loadingSales = false;
  List<SaleModel> salesList = [];
  List<ProductModel> productsSearch = [];
  List<ProductModel> productsSelected = [];
  ClientModel? clientModel;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.read(appProvider.notifier).fetchData();
      productsSearch = ref
              .watch(appProvider)
              .products
              ?.where(
                (product) => productsSelected
                    .every((selected) => selected.id != product.id),
              )
              .toList() ??
          [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool loading = ref.watch(appProvider).loadingHome;
    final List<ProductModel> products = ref.watch(appProvider).products ?? [];
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
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SsTabs(
              tabs: [
                SsTab(
                  title: 'Productos',
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        SsTextfield(
                          onChanged: (value) {
                            try {
                              if (value.isEmpty) {
                                productsSearch = products
                                    .where(
                                      (product) => productsSelected.every(
                                          (selected) =>
                                              selected.id != product.id),
                                    )
                                    .toList();
                              } else {
                                productsSearch = products
                                    .where(
                                      (product) =>
                                          (product.barCode.contains(value) ||
                                              product.name.contains(value)) &&
                                          productsSelected.every((selected) =>
                                              selected.id != product.id),
                                    )
                                    .toList();
                              }
                            } catch (e) {
                              productSelected = null;
                            }
                            setState(() {});
                          },
                          labelText: 'BarCode',
                          controller: _search,
                          // keyboardType: TextInputType.number,
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.digitsOnly,
                          // ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        /* if (productSelected != null) */
                        Expanded(
                          child: SsListView(
                            itemCount: productsSearch.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    bottom: 5,
                                  ),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(productsSearch[index].name),
                                      ),
                                      Expanded(
                                        child: Text(
                                          productsSearch[index]
                                              .stock
                                              .toString(),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              productsSearch[index]
                                                  .salePrice
                                                  .toMoney(),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SsButton(
                                              padding: const EdgeInsets.all(5),
                                              text: 'Añadir',
                                              fontSize: 15,
                                              onPressed: () async {
                                                await showDialog<
                                                    Map<String, dynamic>>(
                                                  context: context,
                                                  builder: (context) => Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      child: Center(
                                                          child: SsCard(
                                                        width: double.infinity,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            const Text(
                                                              'Cantidad',
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            SsTextfield(
                                                              controller:
                                                                  _stock,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly,
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            SsButton(
                                                              text: 'Añadir',
                                                              onPressed: () {
                                                                if (_stock.text
                                                                        .isEmpty ||
                                                                    int.parse(_stock
                                                                            .text) ==
                                                                        0) {
                                                                  SsAlert
                                                                      .showAutoDismissSnackbar(
                                                                    context,
                                                                    Colors.red,
                                                                    'Cantidad no válida',
                                                                  );
                                                                  return;
                                                                }
                                                                if (int.parse(_stock
                                                                        .text) >
                                                                    productsSearch[
                                                                            index]
                                                                        .stock) {
                                                                  SsAlert
                                                                      .showAutoDismissSnackbar(
                                                                    context,
                                                                    Colors.red,
                                                                    'No hay suficiente stock',
                                                                  );
                                                                  return;
                                                                }

                                                                productsSelected
                                                                    .add(
                                                                  productsSearch[
                                                                          index]
                                                                      .copyWith(
                                                                    stock: int.parse(
                                                                        _stock
                                                                            .text),
                                                                  ),
                                                                );
                                                                if (_search.text
                                                                    .isEmpty) {
                                                                  productsSearch =
                                                                      products
                                                                          .where(
                                                                            (product) => productsSelected.every((selected) =>
                                                                                selected.id !=
                                                                                product.id),
                                                                          )
                                                                          .toList();
                                                                } else {
                                                                  productsSearch =
                                                                      products
                                                                          .where(
                                                                            (product) =>
                                                                                (product.barCode.contains(_search.text) || product.name.contains(_search.text)) &&
                                                                                productsSelected.every((selected) => selected.id != product.id),
                                                                          )
                                                                          .toList();
                                                                }
                                                                _stock.text =
                                                                    '1';
                                                                setState(() {});
                                                                Navigator.pop(
                                                                    context, {
                                                                  'stock':
                                                                      _search
                                                                          .text,
                                                                });
                                                              },
                                                              width: 100,
                                                            )
                                                          ],
                                                        ),
                                                      )),
                                                    ),
                                                  ),
                                                );
                                              },
                                              width: 100,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SsTab(
                  title: 'Venta',
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: SsListView(
                            itemCount: productsSelected.length,
                            itemBuilder: (context, index) {
                              String total =
                                  (productsSelected[index].salePrice *
                                          productsSelected[index].stock)
                                      .toMoney();
                              return Padding(
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: Text(
                                              productsSelected[index].name)),
                                      Text(
                                        productsSelected[index]
                                            .stock
                                            .toString(),
                                      ),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                      Text(
                                        total,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SsButton(
                                        padding: const EdgeInsets.all(5),
                                        fontSize: 15,
                                        text: 'Eliminar',
                                        onPressed: () {
                                          productsSelected.removeAt(index);
                                          if (_search.text.isEmpty) {
                                            productsSearch = products
                                                .where(
                                                  (product) => productsSelected
                                                      .every((selected) =>
                                                          selected.id !=
                                                          product.id),
                                                )
                                                .toList();
                                          } else {
                                            productsSearch = products
                                                .where(
                                                  (product) =>
                                                      (product.barCode.contains(
                                                              _search.text) ||
                                                          product.name.contains(
                                                              _search.text)) &&
                                                      productsSelected.every(
                                                          (selected) =>
                                                              selected.id !=
                                                              product.id),
                                                )
                                                .toList();
                                          }
                                          setState(() {});
                                        },
                                        width: 110,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Total:'),
                                  Text(productsSelected
                                      .fold(
                                          0,
                                          (sum, product) =>
                                              sum +
                                              product.salePrice.toInt() *
                                                  product.stock)
                                      .toDouble()
                                      .toMoney()),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SsDropdown<ClientModel>(
                                options: ref.read(homeProvider).clients ?? [],
                                itemBuilder: (item) => Text(item.email),
                                onChanged: (value) {
                                  clientModel = value;
                                },
                                initialValue: clientModel,
                              ),
                              const SizedBox(height: 20),
                              SsButton(
                                loading: loading || loadingSales,
                                text: 'Realizar venta',
                                onPressed: () async {
                                  if (productsSelected.isEmpty) {
                                    SsAlert.showAutoDismissSnackbar(context,
                                        Colors.red, 'No hay productos');
                                    return;
                                  }
                                  if (clientModel?.email == null ||
                                      clientModel!.email.isEmpty) {
                                    SsAlert.showAutoDismissSnackbar(
                                        context, Colors.red, 'No hay cliente');
                                    return;
                                  }
                                  setState(() => loadingSales = true);
                                  await ref.read(appProvider.notifier).sendSale(
                                      productsSelected,
                                      context,
                                      clientModel!.email);
                                  setState(() => loadingSales = false);
                                },
                                fontSize: 16,
                                padding: const EdgeInsets.all(7),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
