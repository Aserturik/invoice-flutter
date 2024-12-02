import 'package:auto_route/auto_route.dart';
import 'package:facturacion/pages/home_page/home_provider.dart';
import 'package:facturacion/widgets/ss_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class AuthSignUpPage extends ConsumerStatefulWidget {
  const AuthSignUpPage({super.key});

  @override
  ConsumerState<AuthSignUpPage> createState() => _AuthSignUpPageState();
}

class _AuthSignUpPageState extends ConsumerState<AuthSignUpPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.read(homeProvider.notifier).fetchDataClients();
    });
  }

  @override
  Widget build(BuildContext context) {
    final people = ref.watch(homeProvider).clients;
    return Scaffold(
      body: Column(
        children: [SsDropdown(options: people ?? [])],
      ),
    );
  }
}
