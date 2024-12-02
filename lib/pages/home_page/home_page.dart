import 'package:auto_route/auto_route.dart';
import 'package:facturacion/pages/app_provider.dart';
import 'package:facturacion/pages/home_page/home_provider.dart';
import 'package:facturacion/pages/home_page/widgets/home_buy.dart';
import 'package:facturacion/pages/home_page/widgets/home_clients.dart';
import 'package:facturacion/pages/home_page/widgets/home_invoice.dart';
import 'package:facturacion/pages/home_page/widgets/home_products.dart';
import 'package:facturacion/routes/app_router.dart';
import 'package:facturacion/routes/app_router.gr.dart';
import 'package:facturacion/shared/constants/constants.dart';
import 'package:facturacion/shared/network/local_network.dart';
import 'package:facturacion/widgets/ss_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.read(appProvider.notifier).fetchData();
      await ref.read(homeProvider.notifier).fetchDataClients();
      await ref.read(homeProvider.notifier).fetchDataEmployees();
      await ref.read(homeProvider.notifier).fetchDataSales();
      await ref.read(homeProvider.notifier).fetchDataBuys();
    });
  }

  Future<void> scanBarCode({loading = true}) async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
      "#ff6666",
      "Cancel",
      true,
      ScanMode.BARCODE,
    )?.listen((barcode) async {
      final product =
          await ref.read(appProvider.notifier).searchProduct(barcode);
      if (product != null) {
        appRouter.push(ProductEditRoute(product: product));
      } else {
        appRouter.push(ProductAddRoute(barcode: barcode));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final page = ref.watch(homeProvider).page;
    String icon = 'assets/icon/add_producto.png';
    Widget child = const HomePage();
    switch (page) {
      case HomePages.products:
        icon = 'assets/icon/add_producto.png';
        child = const HomeProducts();
        break;
      case HomePages.clientes:
        icon = 'assets/icon/clients.png';
        child = const HomeClients();
        break;
      case HomePages.invoice:
        icon = 'assets/icon/invoice.png';
        child = const HomeInvoice();
        break;
      case HomePages.buy:
        icon = 'assets/icon/buy.png';
        child = const HomeBuy();
        break;
      default:
        icon = 'assets/icon/add_producto.png';
        child = const HomeProducts();
        break;
    }
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: SsColors.orange,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: IconButton(
                icon: const Image(
                  image: AssetImage(
                    'assets/icon/add_producto.png',
                  ),
                  height: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  ref.read(homeProvider.notifier).setPage(HomePages.products);
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: const Image(
                  image: AssetImage(
                    'assets/icon/clients.png',
                  ),
                  height: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  ref.read(homeProvider.notifier).setPage(HomePages.clientes);
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: const Image(
                  image: AssetImage(
                    'assets/icon/invoice.png',
                  ),
                  height: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  ref.read(homeProvider.notifier).setPage(HomePages.invoice);
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: const Image(
                  image: AssetImage(
                    'assets/icon/buy.png',
                  ),
                  height: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  ref.read(homeProvider.notifier).setPage(HomePages.buy);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: SsColors.green,
        onPressed: () async {
          switch (page) {
            case HomePages.products:
              await scanBarCode();
              break;
            case HomePages.clientes:
              appRouter.push(ClientAddRoute());
              break;
            case HomePages.invoice:
              appRouter.push(const SaleRoute());
              break;
            case HomePages.buy:
              appRouter.push(const BuyRoute());
              break;
            default:
              await scanBarCode();
              break;
          }
        },
        child: Image(
          image: AssetImage(
            icon,
          ),
          height: 30,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.person_outline, color: Colors.black),
            onSelected: (value) async {
              switch (value) {
                case 'logOut':
                  await CacheNetwork.deleteCacheData(key: "jwtToken");
                  jwtToken = null;
                  await appRouter.push(const AuthSignInRoute());
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'logOut',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Cerrar sesion'),
                      Icon(Icons.logout),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: child,
    );
  }
}
