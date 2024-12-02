import 'package:auto_route/auto_route.dart';
import 'package:facturacion/pages/app_provider.dart';
import 'package:facturacion/routes/app_router.dart';
import 'package:facturacion/widgets/ss_alert.dart';
import 'package:facturacion/widgets/ss_button.dart';
import 'package:facturacion/widgets/ss_dropdown.dart';
import 'package:facturacion/widgets/ss_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class AuthSignUpPage extends ConsumerStatefulWidget {
  const AuthSignUpPage({super.key});

  @override
  ConsumerState<AuthSignUpPage> createState() => _AuthSignUpPageState();
}

class _AuthSignUpPageState extends ConsumerState<AuthSignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _documentController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? cc;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear usuario'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            appRouter.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Image(
                image: AssetImage('assets/imagen/logo.png'),
                height: 100,
              ),
            ),
            const SizedBox(height: 10),
            SsTextfield(
              labelText: 'Nombre completo',
              controller: _nameController,
            ),
            const SizedBox(height: 10),
            SsTextfield(
              labelText: 'Numero documento',
              controller: _documentController,
            ),
            const SizedBox(height: 10),
            SsDropdown(
              options: const ['CC', 'CE', 'TI'],
              hint: 'Tipo documento',
              initialValue: cc,
              onChanged: (value) {
                cc = value;
              },
            ),
            const SizedBox(height: 10),
            SsTextfield(
              labelText: 'Correo',
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
            ),
            const SizedBox(height: 10),
            SsTextfield(
              labelText: 'Telefono',
              keyboardType: TextInputType.phone,
              controller: _phoneController,
            ),
            const SizedBox(height: 10),
            SsTextfield(
              labelText: 'Contraseña',
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              controller: _passwordController,
            ),
            const SizedBox(height: 20),
            SsButton(
                loading: loading,
                text: 'Crear usuario',
                onPressed: () async {
                  if (cc == null) {
                    SsAlert.showAutoDismissSnackbar(
                        context, Colors.red, 'Seleccione un tipo de documento');
                    return;
                  }
                  if (_nameController.text.isEmpty) {
                    SsAlert.showAutoDismissSnackbar(
                        context, Colors.red, 'Por favor ingrese un nombre');
                    return;
                  }
                  if (_documentController.text.isEmpty) {
                    SsAlert.showAutoDismissSnackbar(
                        context, Colors.red, 'Por favor ingrese un documento');
                    return;
                  }
                  if (_emailController.text.isEmpty) {
                    SsAlert.showAutoDismissSnackbar(
                        context, Colors.red, 'Por favor ingrese un correo');
                    return;
                  }
                  if (_passwordController.text.isEmpty) {
                    SsAlert.showAutoDismissSnackbar(context, Colors.red,
                        'Por favor ingrese una contraseña');
                    return;
                  }
                  setState(() {
                    loading = true;
                  });
                  try {
                    await ref.read(appProvider.notifier).signInPress(
                          correo: _emailController.text,
                          password: _passwordController.text,
                          document: _documentController.text,
                          name: _nameController.text,
                          phone: _phoneController.text,
                          documentType: cc!,
                        );
                    appRouter.back();
                  } catch (e) {
                    SsAlert.showAutoDismissSnackbar(
                        appRouter.navigatorKey.currentContext!,
                        Colors.red,
                        e.toString());
                  } finally {
                    setState(() {
                      loading = false;
                    });
                  }
                }),
          ],
        ),
      ),
    );
  }
}
