import 'package:flutter/material.dart';

class SsColors {
  // Color de fondo principal
  static const Color primaryBackground = Color(0xFF1E1E2C);

  // Colores de texto
  static const Color primaryText = Color(0xFFFFFFFF);
  static const Color secondaryText = Color(0xFFB0BEC5);

  // Colores de botones
  static const Color primaryButton = Color(0xFF3F51B5);
  static const Color secondaryButton = Color(0xFF607D8B);

  // Colores de acento
  static const Color accent = Color(0xFFFFC107);

  // Colores de error
  static const Color error = Color(0xFFD32F2F);

  // Método para obtener colores en diferentes opacidades si se necesita
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  // static const Color orange = Color.fromRGBO(231, 111, 81, 1);
  static const Color orange = Color.fromRGBO(238, 106, 34, 1);
  static const Color brown = Color.fromRGBO(183, 89, 38, 1);
  static const Color green = Color.fromRGBO(42, 157, 143, 1);
  static const Color yellow = Color.fromRGBO(233, 196, 106, 1);
  static const Color blue = Color.fromRGBO(38, 70, 83, 1);
}
