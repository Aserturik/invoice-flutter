import 'package:flutter/material.dart';

class SsCard extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Color? boderColor;
  final double? borderWidth;
  const SsCard({
    required this.child,
    this.backgroundColor,
    this.width,
    this.padding,
    this.borderRadius,
    this.boderColor,
    this.borderWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: boderColor ?? Colors.black,
          width: borderWidth ?? 1,
        ),
        color: backgroundColor,
        borderRadius: borderRadius ?? BorderRadius.circular(10),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}
