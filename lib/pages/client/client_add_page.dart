import 'package:auto_route/auto_route.dart';
import 'package:facturacion/models/client_model.dart';
import 'package:facturacion/pages/home_page/home_provider.dart';
import 'package:facturacion/routes/app_router.dart';
import 'package:facturacion/widgets/ss_button.dart';
import 'package:facturacion/widgets/ss_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ClientAddPage extends ConsumerStatefulWidget {
  final ClientModel? client;
  const ClientAddPage({
    this.client,
    super.key,
  });

  @override
  ConsumerState<ClientAddPage> createState() => _ProductAddPageState();
}

class _ProductAddPageState extends ConsumerState<ClientAddPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _documentNumberController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String cc = 'CC';
  bool loadingClient = false;

  @override
  void initState() {
    super.initState();
    if (widget.client != null) {
      _nameController.text = widget.client!.name;
      _documentNumberController.text = widget.client!.documentNumber.toString();
      _phoneController.text = widget.client!.phone;
      _emailController.text = widget.client!.email;
      cc = widget.client!.documentType;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final loading = ref.watch(appProvider).loadingHome;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(238, 106, 34, 1),
        title: Text(
            widget.client == null ? 'Nuevo Cliente' : 'Actualizar Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text('Nombre cliente'),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre',
                ),
                controller: _nameController,
              ),
              const SizedBox(height: 10),
              const Text('Numero de documento'),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Numero',
                ),
                controller: _documentNumberController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
              ),
              const SizedBox(height: 10),
              const Text('Email del cliente'),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              const Text('Numero de telefono'),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Telefono',
                ),
                controller: _phoneController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
              ),
              const SizedBox(height: 10),
              const Text('Tipo de documento'),
              SsDropdown(
                options: const ['CC', 'CE', 'TI'],
                initialValue: cc,
                hint: 'Tipo de documento',
                onChanged: (value) => cc = value.toString(),
              ),
              const SizedBox(height: 20),
              SsButton(
                fontSize: 20,
                loading: loadingClient,
                enable: !loadingClient,
                onPressed: () async {
                  setState(() {
                    loadingClient = true;
                  });
                  if (widget.client == null) {
                    await ref.read(homeProvider.notifier).addClient(
                            client: ClientModel(
                          id: 1,
                          name: _nameController.text,
                          documentNumber:
                              int.parse(_documentNumberController.text),
                          email: _emailController.text,
                          phone: _phoneController.text,
                          documentType: cc,
                        )
                            // stock: int.parse(_stockController.text),
                            );
                  } else {
                    await ref.read(homeProvider.notifier).updateClient(
                          client: ClientModel(
                            id: widget.client!.id,
                            name: _nameController.text,
                            documentNumber:
                                int.parse(_documentNumberController.text),
                            email: _emailController.text,
                            phone: _phoneController.text,
                            documentType: cc,
                          ),
                        );
                  }
                  setState(() {
                    loadingClient = false;
                  });
                  appRouter.back();
                  await ref.read(homeProvider.notifier).fetchDataClients();
                },
                text: widget.client == null ? 'Añadir' : 'Actualizar',
                backgroundColor: const Color.fromRGBO(238, 106, 34, 1),
              )
            ],
          ),
        ),
      ),
    );
  }
}
