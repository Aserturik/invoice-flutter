import 'package:facturacion/pages/app_provider.dart';
import 'package:facturacion/widgets/ss_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeClients extends ConsumerStatefulWidget {
  const HomeClients({
    super.key,
  });

  @override
  ConsumerState<HomeClients> createState() => _HomeClientsState();
}

class _HomeClientsState extends ConsumerState<HomeClients> {
  @override
  Widget build(BuildContext context) {
    final bool loading = ref.watch(appProvider).loadingHome;
    return loading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [SsCard(child: Text('hola'))],
                ),
              );
            },
            itemCount: 8,
          );
  }
}
