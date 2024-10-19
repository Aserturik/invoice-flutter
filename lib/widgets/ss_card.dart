import 'package:flutter/material.dart';

class SsCard extends StatelessWidget {
  final Color backgroundColor;
  final Widget child;
  final double? width;
  final EdgeInsetsGeometry? padding;
  const SsCard({
    required this.child,
    this.backgroundColor = Colors.white,
    this.width,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}
