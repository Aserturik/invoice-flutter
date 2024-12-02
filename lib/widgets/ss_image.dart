import 'package:flutter/material.dart';

class SsImage extends StatelessWidget {
  final String imageUrl; // URL de la imagen a cargar
  final double? width; // Ancho opcional de la imagen
  final double? height; // Altura opcional de la imagen
  final BoxFit fit; // Cómo ajustar la imagen dentro del contenedor

  const SsImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0), // Opcional: redondear bordes
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[200], // Color de fondo opcional
        ),
        child: Image.network(
          imageUrl,
          width: width,
          height: height,
          fit: fit,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child; // Imagen cargada con éxito
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          },
          errorBuilder:
              (BuildContext context, Object error, StackTrace? stackTrace) {
            // En caso de error, mostrar imagen predeterminada
            return Image.asset(
              'assets/imagen/no_image.png',
              width: width,
              height: height,
              fit: BoxFit.contain,
            );
          },
        ),
      ),
    );
  }
}
