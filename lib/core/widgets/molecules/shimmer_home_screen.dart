import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:imdumb/core/constants/app_keys.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
import 'package:imdumb/core/widgets/molecules/shimmer_carousel.dart';
import 'package:imdumb/core/widgets/molecules/shimmer_list.dart';
import 'package:imdumb/features/home/presentation/widgets/home_app_bar.dart';

/// Molecule: ShimmerHomeScreen
///
/// Widget reutilizable para mostrar un shimmer loader que replica la estructura
/// de la pantalla principal (Home). Incluye shimmer para:
/// - AppBar
/// - Carrusel de películas populares
/// - Sección de películas en cartelera
/// - Sección de películas mejor calificadas
/// - Secciones de géneros
///
/// SOLID: Single Responsibility Principle (SRP)
///
/// Este widget tiene una única responsabilidad: mostrar shimmer loaders
/// para la pantalla principal. Elimina duplicación de código
/// y proporciona una experiencia de usuario consistente durante la carga.
///
/// Patrón aplicado: Reusable Component (Atomic Design - Molecule)
class ShimmerHomeScreen extends StatelessWidget {
  const ShimmerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColor;
    final screenHeight = context.screenHeight;

    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            // Shimmer para la imagen de fondo
            Shimmer.fromColors(
              baseColor: appColor.surfaceContainer,
              highlightColor: appColor.surfaceContainerHigh,
              child: Container(
                width: double.infinity,
                height: screenHeight,
                color: appColor.surfaceContainer,
              ),
            ),
            CustomScrollView(
              key: AppKeys.homeScrollView,
              slivers: [
                const HomeAppBar(),
                // Shimmer para título de películas populares
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16.0,
                    ),
                    child: Shimmer.fromColors(
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
                  ),
                ),
                // Shimmer para carrusel de películas populares
                SliverToBoxAdapter(
                  child: ShimmerCarousel(
                    height: 400,
                    itemCount: 3,
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 32)),
                // Shimmer para título de películas en cartelera
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Shimmer.fromColors(
                          baseColor: appColor.surfaceContainer,
                          highlightColor: appColor.surfaceContainerHigh,
                          child: Container(
                            width: 180,
                            height: 24,
                            decoration: BoxDecoration(
                              color: appColor.surfaceContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: appColor.surfaceContainer,
                          highlightColor: appColor.surfaceContainerHigh,
                          child: Container(
                            width: 80,
                            height: 24,
                            decoration: BoxDecoration(
                              color: appColor.surfaceContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                    const SliverToBoxAdapter(child: SizedBox(height: 16)),
                // Shimmer para lista de películas en cartelera
                SliverToBoxAdapter(
                  child: const ShimmerList(
                    itemHeight: 280,
                    itemWidth: 160,
                    itemCount: 5,
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 32)),
                // Shimmer para título de películas mejor calificadas
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                        Shimmer.fromColors(
                          baseColor: appColor.surfaceContainer,
                          highlightColor: appColor.surfaceContainerHigh,
                          child: Container(
                            width: 80,
                            height: 24,
                            decoration: BoxDecoration(
                              color: appColor.surfaceContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                    const SliverToBoxAdapter(child: SizedBox(height: 16)),
                // Shimmer para lista de películas mejor calificadas
                SliverToBoxAdapter(
                  child: const ShimmerList(
                    itemHeight: 280,
                    itemWidth: 160,
                    itemCount: 5,
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 32)),
                // Shimmer para secciones de géneros (2-3 secciones)
                ...List.generate(2, (index) {
                  return Column(
                    children: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Shimmer.fromColors(
                                baseColor: appColor.surfaceContainer,
                                highlightColor: appColor.surfaceContainerHigh,
                                child: Container(
                                  width: 150,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: appColor.surfaceContainer,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor: appColor.surfaceContainer,
                                highlightColor: appColor.surfaceContainerHigh,
                                child: Container(
                                  width: 80,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: appColor.surfaceContainer,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 16)),
                      const SliverToBoxAdapter(
                        child: ShimmerList(
                          itemHeight: 280,
                          itemWidth: 160,
                          itemCount: 5,
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 32)),
                    ],
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
