import 'package:flutter/material.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
import 'package:imdumb/core/utils/extension/sizedbox_extension.dart';

/// Molecule: Fila de rating con estrella, valor y año opcional
/// 
/// Widget reutilizable que muestra:
/// - Icono de estrella (amber)
/// - Valor del rating (formateado)
/// - Año de estreno (opcional)
class RatingRow extends StatelessWidget {
  final String rating;
  final int? year;
  final double starSize;
  final double fontSize;
  final Color? textColor;

  const RatingRow({
    super.key,
    required this.rating,
    this.year,
    this.starSize = 14,
    this.fontSize = 12,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTextColor = textColor ?? context.appColor.onSurfaceVariant;

    return Row(
      children: [
        Icon(Icons.star, color: Colors.amber, size: starSize),
        4.spacew,
        Text(
          rating,
          style: TextStyle(
            color: effectiveTextColor,
            fontSize: fontSize,
          ),
        ),
        if (year != null) ...[
          16.spacew,
          Text(
            '$year',
            style: TextStyle(
              color: effectiveTextColor,
              fontSize: fontSize,
            ),
          ),
        ],
      ],
    );
  }
}
