import 'package:auto_route/auto_route.dart';
import 'package:facturacion/models/client_model.dart';
import 'package:facturacion/models/product_model.dart';
import 'package:facturacion/pages/app_provider.dart';
import 'package:facturacion/utils/date_extension.dart';
import 'package:facturacion/utils/double_extension.dart';
import 'package:facturacion/widgets/ss_alert.dart';
import 'package:facturacion/widgets/ss_button.dart';
import 'package:facturacion/widgets/ss_card.dart';
import 'package:facturacion/widgets/ss_colors.dart';
import 'package:facturacion/widgets/ss_dateinput.dart';
import 'package:facturacion/widgets/ss_list_view.dart';
import 'package:facturacion/widgets/ss_tabs.dart';
import 'package:facturacion/widgets/ss_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class BuyPage extends ConsumerStatefulWidget {
  const BuyPage({super.key});

  @override
  ConsumerState<BuyPage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<BuyPage> {
  ProductModel? productSelected;
  final TextEditingController _search = TextEditingController();
  final TextEditingController _stock = TextEditingController(text: '1');
  final TextEditingController _price = TextEditingController();
  final TextEditingController _expirationDate = TextEditingController();
  final TextEditingController _purchaseNumber = TextEditingController();
  final TextEditingController _batchNumber = TextEditingController();
  bool loadingSales = false;
  List<SaleModel> salesList = [];
  List<ProductModel> productsSearch = [];
  List<ProductModel> productsSelected = [];
  List<ProductModel> products = [];
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
    products = ref.watch(appProvider).products ?? [];

    Future<void> scanBarCode({loading = true}) async {
      FlutterBarcodeScanner.getBarcodeStreamReceiver(
        "#ff6666",
        "Cancel",
        true,
        ScanMode.BARCODE,
      )?.listen((barcode) async {
        _search.text = barcode;
        if (_search.text.isEmpty) {
          productsSearch = products
              .where(
                (product) => productsSelected
                    .every((selected) => selected.id != product.id),
              )
              .toList();
        } else {
          productsSearch = products
              .where(
                (product) =>
                    (product.barCode.contains(_search.text) ||
                        product.name.contains(_search.text)) &&
                    productsSelected
                        .every((selected) => selected.id != product.id),
              )
              .toList();
        }
        setState(() {});
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: SsColors.orange,
        title: const Text('Compra'),
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
                        Row(
                          children: [
                            Expanded(
                              child: SsTextfield(
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
                                                (product.barCode
                                                        .contains(value) ||
                                                    product.name
                                                        .contains(value)) &&
                                                productsSelected.every(
                                                    (selected) =>
                                                        selected.id !=
                                                        product.id),
                                          )
                                          .toList();
                                    }
                                  } catch (e) {
                                    productSelected = null;
                                  }
                                  setState(() {});
                                },
                                labelText: 'Nombre o BarCode',
                                controller: _search,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SsButton(
                                width: 100,
                                text: 'Cam',
                                onPressed: scanBarCode),
                          ],
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
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(productsSearch[index].name),
                                            Text(productsSearch[index].barCode),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          productsSearch[index]
                                              .stock
                                              .toString(),
                                          textAlign: TextAlign.center,
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
                                                  .purchasePrice
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
                                                _price.text =
                                                    productsSearch[index]
                                                        .purchasePrice
                                                        .toInt()
                                                        .toString();
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
                                                            const Text(
                                                              'Precio costo',
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            SsTextfield(
                                                              controller:
                                                                  _price,
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
                                                                if (double.parse(
                                                                        _price
                                                                            .text) <=
                                                                    0) {
                                                                  SsAlert
                                                                      .showAutoDismissSnackbar(
                                                                    context,
                                                                    Colors.red,
                                                                    'Precio de compra no válido',
                                                                  );
                                                                  return;
                                                                }
                                                                productsSelected
                                                                    .add(
                                                                  productsSearch[
                                                                          index]
                                                                      .copyWith(
                                                                    stock: int
                                                                        .parse(
                                                                      _stock
                                                                          .text,
                                                                    ),
                                                                    purchasePrice:
                                                                        double.parse(
                                                                            _price.text),
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
                  title: 'Compra',
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
                                  (productsSelected[index].purchasePrice *
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
                                              product.purchasePrice.toInt() *
                                                  product.stock)
                                      .toDouble()
                                      .toMoney()),
                                ],
                              ),
                              const SizedBox(height: 20),
                              SsTextfield(
                                labelText: 'Numero de factura',
                                controller: _purchaseNumber,
                              ),
                              const SizedBox(height: 10),
                              SsTextfield(
                                labelText: 'Numero de lote',
                                controller: _batchNumber,
                              ),
                              const SizedBox(height: 10),
                              SsDateInput(
                                labelText: 'Fecha de vencimiento',
                                controller: _expirationDate,
                              ),
                              const SizedBox(height: 20),
                              SsButton(
                                loading: loading || loadingSales,
                                text: 'Realizar compra',
                                onPressed: () async {
                                  if (productsSelected.isEmpty) {
                                    SsAlert.showAutoDismissSnackbar(context,
                                        Colors.red, 'No hay productos');
                                    return;
                                  }
                                  if (_purchaseNumber.text.isEmpty) {
                                    SsAlert.showAutoDismissSnackbar(context,
                                        Colors.red, 'Numero de factura vacio');
                                    return;
                                  }
                                  if (_batchNumber.text.isEmpty) {
                                    SsAlert.showAutoDismissSnackbar(context,
                                        Colors.red, 'Numero de lote vacio');
                                    return;
                                  }
                                  if (_expirationDate.text.isEmpty) {
                                    SsAlert.showAutoDismissSnackbar(
                                        context,
                                        Colors.red,
                                        'Fecha de vencimiento vacia');
                                    return;
                                  }
                                  setState(() => loadingSales = true);
                                  await ref.read(appProvider.notifier).sendBuy(
                                        products: productsSelected,
                                        batchNumber: _batchNumber.text,
                                        purchaseNumber: _purchaseNumber.text,
                                        expirationDate: DateTimeFormatting
                                            .convertToIsoFormat(
                                                _expirationDate.text),
                                      );
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
