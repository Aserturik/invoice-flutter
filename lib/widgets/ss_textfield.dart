import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SsTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? labelText;
  final bool obscureText;
  final double? width;
  final Function(String)? onChanged;

  const SsTextfield({
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.labelText,
    this.obscureText = false,
    this.width,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextField(
        onChanged: onChanged,
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
      ),
    );
  }
}
