import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';

/// Molecule: ShimmerList
///
/// Widget reutilizable para mostrar una lista horizontal de shimmer loaders.
///
/// SOLID: Single Responsibility Principle (SRP)
///
/// Este widget tiene una única responsabilidad: mostrar shimmer loaders
/// en formato de lista horizontal. Elimina duplicación de código en
/// múltiples secciones que muestran loading states.
///
/// Patrón aplicado: Reusable Component (Atomic Design - Molecule)
class ShimmerList extends StatelessWidget {
  /// Altura de cada item shimmer
  final double itemHeight;

  /// Ancho de cada item shimmer
  final double itemWidth;

  /// Número de items a mostrar
  final int itemCount;

  /// Espaciado horizontal entre items
  final double spacing;

  /// Border radius de los items
  final double borderRadius;

  const ShimmerList({
    super.key,
    this.itemHeight = 280,
    this.itemWidth = 160,
    this.itemCount = 5,
    this.spacing = 12.0,
    this.borderRadius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColor;

    return SizedBox(
      height: itemHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Container(
            width: itemWidth,
            height: itemHeight,
            margin: EdgeInsets.only(right: spacing),
            child: Shimmer.fromColors(
              baseColor: appColor.surfaceContainer,
              highlightColor: appColor.surfaceContainerHigh,
              child: Container(
                decoration: BoxDecoration(
                  color: appColor.surfaceContainer,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
