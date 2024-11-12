import 'package:facturacion/widgets/Ss_colors.dart';
import 'package:facturacion/widgets/ss_button.dart';
import 'package:flutter/material.dart';

class SsButtonCore extends StatelessWidget {
  final Function() onPressed;
  final String text;
  const SsButtonCore({
    required this.onPressed,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SsButton(
      textColor: Colors.white,
      boderColor: Colors.white,
      borderWidth: 1,
      borderRadius: BorderRadius.circular(30),
      onPressed: onPressed,
      text: text,
      backgroundColor: SsColors.brown,
      width: 200,
    );
  }
}
