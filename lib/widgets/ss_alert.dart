import 'package:flutter/material.dart';

class SsAlert {
  final String text;

  const SsAlert({
    required this.text,
  });

  static Future<void> showAlert(BuildContext context, String text) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Alerta"),
          content: Text(text),
          actions: <Widget>[
            TextButton(
              child: const Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void showAutoDismissSnackbar(
      BuildContext context, Color color, String text) {
    final snackBar = SnackBar(
      backgroundColor: color,
      content: Text(text),
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
