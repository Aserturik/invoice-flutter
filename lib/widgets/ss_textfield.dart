import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SsTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? labelText;
  final bool obscureText;
  const SsTextfield({
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.labelText,
    this.obscureText = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        labelText: labelText,
        fillColor: Colors.white.withOpacity(0.8),
        filled: true,
      ),
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
    );
  }
}
