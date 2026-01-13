import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
import 'package:imdumb/core/utils/extension/sizedbox_extension.dart';

/// Molecule: ShimmerMovieDetail
///
/// Widget reutilizable para mostrar un shimmer loader que replica la estructura
/// de la pantalla de detalle de película. Incluye shimmer para:
/// - AppBar con imagen (carousel/app bar)
/// - Título de la película
/// - Rating y runtime
/// - Descripción
/// - Elenco (cast section)
///
/// SOLID: Single Responsibility Principle (SRP)
///
/// Este widget tiene una única responsabilidad: mostrar shimmer loaders
/// para la pantalla de detalle de película. Elimina duplicación de código
/// y proporciona una experiencia de usuario consistente durante la carga.
///
/// Patrón aplicado: Reusable Component (Atomic Design - Molecule)
class ShimmerMovieDetail extends StatelessWidget {
  const ShimmerMovieDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColor;
    final screenHeight = context.screenHeight;
    final expandedHeight = screenHeight * 0.4;

    return CustomScrollView(
      slivers: [
        // Shimmer para el AppBar/Imagen
        SliverAppBar(
          floating: true,
          pinned: true,
          expandedHeight: expandedHeight,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            background: Shimmer.fromColors(
              baseColor: appColor.surfaceContainer,
              highlightColor: appColor.surfaceContainerHigh,
              child: Container(
                color: appColor.surfaceContainer,
              ),
            ),
          ),
        ),
        // Shimmer para el contenido
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shimmer para el título
                Shimmer.fromColors(
                  baseColor: appColor.surfaceContainer,
                  highlightColor: appColor.surfaceContainerHigh,
                  child: Container(
                    width: double.infinity,
                    height: 32,
                    decoration: BoxDecoration(
                      color: appColor.surfaceContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                16.spaceh,
                // Shimmer para rating y runtime
                Shimmer.fromColors(
                  baseColor: appColor.surfaceContainer,
                  highlightColor: appColor.surfaceContainerHigh,
                  child: Container(
                    width: 200,
                    height: 24,
                    decoration: BoxDecoration(
                      color: appColor.surfaceContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                16.spaceh,
                // Shimmer para géneros
                Shimmer.fromColors(
                  baseColor: appColor.surfaceContainer,
                  highlightColor: appColor.surfaceContainerHigh,
                  child: Container(
                    width: 150,
                    height: 20,
                    decoration: BoxDecoration(
                      color: appColor.surfaceContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                24.spaceh,
                // Shimmer para "Descripción"
                Shimmer.fromColors(
                  baseColor: appColor.surfaceContainer,
                  highlightColor: appColor.surfaceContainerHigh,
                  child: Container(
                    width: 120,
                    height: 24,
                    decoration: BoxDecoration(
                      color: appColor.surfaceContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                12.spaceh,
                // Shimmer para el texto de descripción (múltiples líneas)
                ...List.generate(4, (index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: index < 3 ? 8.0 : 0),
                    child: Shimmer.fromColors(
                      baseColor: appColor.surfaceContainer,
                      highlightColor: appColor.surfaceContainerHigh,
                      child: Container(
                        width: double.infinity,
                        height: 16,
                        decoration: BoxDecoration(
                          color: appColor.surfaceContainer,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  );
                }),
                24.spaceh,
                // Shimmer para "Elenco"
                Shimmer.fromColors(
                  baseColor: appColor.surfaceContainer,
                  highlightColor: appColor.surfaceContainerHigh,
                  child: Container(
                    width: 100,
                    height: 24,
                    decoration: BoxDecoration(
                      color: appColor.surfaceContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                12.spaceh,
                // Shimmer para la lista de actores
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Shimmer.fromColors(
                              baseColor: appColor.surfaceContainer,
                              highlightColor: appColor.surfaceContainerHigh,
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: appColor.surfaceContainer,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            8.spaceh,
                            Shimmer.fromColors(
                              baseColor: appColor.surfaceContainer,
                              highlightColor: appColor.surfaceContainerHigh,
                              child: Container(
                                width: 100,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: appColor.surfaceContainer,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            4.spaceh,
                            Shimmer.fromColors(
                              baseColor: appColor.surfaceContainer,
                              highlightColor: appColor.surfaceContainerHigh,
                              child: Container(
                                width: 80,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: appColor.surfaceContainer,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                80.spaceh,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
