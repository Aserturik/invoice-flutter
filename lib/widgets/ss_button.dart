import 'package:facturacion/widgets/ss_card.dart';
import 'package:flutter/material.dart';

class SsButton extends StatelessWidget {
  final Color? backgroundColor;
  final String text;
  final Function() onPressed;
  final bool enable;
  final bool loading;
  final BorderRadiusGeometry? borderRadius;
  final Color? boderColor;
  final Color? textColor;
  final double? borderWidth;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  const SsButton({
    this.backgroundColor,
    required this.text,
    required this.onPressed,
    this.enable = true,
    this.loading = false,
    this.borderRadius,
    this.boderColor,
    this.borderWidth,
    this.textColor,
    this.width,
    this.padding,
    this.fontSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SsCard(
        boderColor: boderColor,
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        padding: padding ?? const EdgeInsets.all(14),
        width: width ?? double.infinity,
        backgroundColor: enable ? backgroundColor : Colors.grey,
        child: Center(
          child: loading
              ? SizedBox(
                  height: fontSize ??
                      20, // Ajusta el tamaño al esperado para el texto
                  width: fontSize ??
                      20, // Igual altura y ancho para mantener proporción
                  child: const CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(
                  text,
                  style: TextStyle(
                    color: textColor ?? Colors.black,
                    fontSize: fontSize ?? 20,
                  ),
                ),
        ),
      ),
    );
  }
}
