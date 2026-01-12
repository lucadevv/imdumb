import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';

/// Molecule: ShimmerCarousel
/// 
/// Widget reutilizable para mostrar un carousel horizontal de shimmer loaders.
/// 
/// SOLID: Single Responsibility Principle (SRP)
/// 
/// Este widget tiene una única responsabilidad: mostrar shimmer loaders
/// en formato de carousel horizontal. Especializado para carousels como
/// el de películas populares.
/// 
/// Patrón aplicado: Reusable Component (Atomic Design - Molecule)
class ShimmerCarousel extends StatelessWidget {
  /// Altura del carousel
  final double height;
  
  /// Ancho de cada card
  final double? cardWidth;
  
  /// Número de items a mostrar
  final int itemCount;
  
  /// Espaciado horizontal entre items
  final double spacing;
  
  /// Border radius de los items
  final double borderRadius;

  const ShimmerCarousel({
    super.key,
    required this.height,
    this.cardWidth,
    this.itemCount = 3,
    this.spacing = 8.0,
    this.borderRadius = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColor;
    final screenWidth = context.screenWidth;
    final width = cardWidth ?? (screenWidth * 0.8);

    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Container(
            width: width,
            margin: EdgeInsets.symmetric(horizontal: spacing),
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
