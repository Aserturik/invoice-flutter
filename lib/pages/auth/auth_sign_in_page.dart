import 'package:auto_route/auto_route.dart';
import 'package:facturacion/pages/app_provider.dart';
import 'package:facturacion/routes/app_router.dart';
import 'package:facturacion/routes/app_router.gr.dart';
import 'package:facturacion/widgets/ss_alert.dart';
import 'package:facturacion/widgets/ss_button_core.dart';
import 'package:facturacion/widgets/ss_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class AuthSignInPage extends ConsumerStatefulWidget {
  const AuthSignInPage({super.key});

  @override
  ConsumerState<AuthSignInPage> createState() => _AuthSignInPageState();
}

class _AuthSignInPageState extends ConsumerState<AuthSignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool loading = false;

  Future<void> signUpPress() async {
    loading = true;
    setState(() {});
    if (emailController.text.isEmpty) {
      SsAlert.showAutoDismissSnackbar(
          context, Colors.red, 'Por favor ingresa un correo');
      return;
    }

    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegex.hasMatch(emailController.text)) {
      SsAlert.showAutoDismissSnackbar(
          context, Colors.red, 'Ingresa un correo válido');
      return;
    }

    if (passwordController.text.isEmpty) {
      SsAlert.showAutoDismissSnackbar(
          context, Colors.red, 'Por favor ingresa una contraseña');
      return;
    }
    try {
      await ref.read(appProvider.notifier).signUpPress(
            correo: emailController.text,
            password: passwordController.text,
          );
      appRouter.push(const HomeRoute());
      SsAlert.showAutoDismissSnackbar(
          context, Colors.green, 'Inicio de sesión exitoso');
    } catch (e) {
      SsAlert.showAutoDismissSnackbar(
          context, Colors.red, 'Error al iniciar sesión');
    } finally {
      loading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Image(image: AssetImage('assets/imagen/logo.png')),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(238, 106, 34, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sing in',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        RotationTransition(
                          turns: const AlwaysStoppedAnimation(45 / 360),
                          child: Image(
                            image: const AssetImage(
                              'assets/icon/huella.png',
                            ),
                            width: 50,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    SsTextfield(
                      controller: emailController,
                      labelText: 'Correo',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    SsTextfield(
                      controller: passwordController,
                      labelText: 'contraseña',
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    if (loading)
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    else
                      Center(
                        child: SsButtonCore(
                          onPressed: () {
                            signUpPress();
                          },
                          text: 'Ingresar',
                        ),
                      ),
                    const SizedBox(height: 20),
                    Center(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                          ),
                          child: const Text(
                            '  Olvide mi contraseña  ',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
