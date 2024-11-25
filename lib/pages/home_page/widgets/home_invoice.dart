import 'package:facturacion/widgets/ss_card.dart';
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
    return ListView.builder(
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [SsCard(child: Text('xd'))],
          ),
        );
      },
      itemCount: 8,
    );
  }
}
