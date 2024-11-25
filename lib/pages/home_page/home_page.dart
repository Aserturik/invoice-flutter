import 'package:auto_route/auto_route.dart';
import 'package:facturacion/pages/app_provider.dart';
import 'package:facturacion/pages/home_page/home_provider.dart';
import 'package:facturacion/pages/home_page/widgets/home_clients.dart';
import 'package:facturacion/pages/home_page/widgets/home_invoice.dart';
import 'package:facturacion/pages/home_page/widgets/home_products.dart';
import 'package:facturacion/routes/app_router.dart';
import 'package:facturacion/routes/app_router.gr.dart';
import 'package:facturacion/shared/constants/constants.dart';
import 'package:facturacion/shared/network/local_network.dart';
import 'package:facturacion/widgets/ss_colors.dart';
import 'package:flutter/material.dart';
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
      await ref.read(homeProvider.notifier).fetchDataSales();
    });
  }

  @override
  Widget build(BuildContext context) {
    final page = ref.watch(homeProvider).page;
    Widget child = const HomePage();
    switch (page) {
      case HomePages.products:
        child = const HomeProducts();
        break;
      case HomePages.clientes:
        child = const HomeClients();
        break;
      case HomePages.invoice:
        child = const HomeInvoice();
        break;
      default:
        child = const HomeInvoice();
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
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     await scanBarCode();
      //   },
      //   child: const Icon(Icons.add),
      // ),
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
            onSelected: (value) async {
              switch (value) {
                case 'addProduct':
                  appRouter.push(ProductAddRoute());
                  break;
                case 'sale':
                  appRouter.push(const SaleRoute());
                  break;
                case 'addClient':
                  appRouter.push(const ClientAddRoute());
                  break;
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
                  value: 'addProduct',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Añadir nuevo producto'),
                      Image(
                        image: AssetImage(
                          'assets/icon/add_producto.png',
                        ),
                        height: 30,
                      ),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'sale',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nueva venta'),
                      Image(
                        image: AssetImage(
                          'assets/icon/buy.png',
                        ),
                        height: 30,
                      ),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'addClient',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nueva cliente'),
                      Image(
                        image: AssetImage(
                          'assets/icon/buy.png',
                        ),
                        height: 30,
                      ),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'logOut',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Cerrar sesion'),
                      Image(
                        image: AssetImage(
                          'assets/icon/log_out.png',
                        ),
                        height: 30,
                        color: Colors.black,
                      ),
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
