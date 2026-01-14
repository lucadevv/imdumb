import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:imdumb/core/constants/app_keys.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
import 'package:imdumb/features/movies_list/presentation/widgets/movies_list_app_bar.dart';

/// Molecule: ShimmerMoviesListScreen
///
/// Widget reutilizable para mostrar un shimmer loader que replica la estructura
/// de la pantalla de lista de películas. Incluye shimmer para:
/// - AppBar
/// - Grid de películas
///
/// SOLID: Single Responsibility Principle (SRP)
///
/// Este widget tiene una única responsabilidad: mostrar shimmer loaders
/// para la pantalla de lista de películas. Elimina duplicación de código
/// y proporciona una experiencia de usuario consistente durante la carga.
///
/// Patrón aplicado: Reusable Component (Atomic Design - Molecule)
class ShimmerMoviesListScreen extends StatelessWidget {
  final String title;

  const ShimmerMoviesListScreen({super.key, this.title = 'Lista de Películas'});

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColor;

    return Scaffold(
      body: CustomScrollView(
        key: AppKeys.moviesListScrollView,
        slivers: [
          MoviesListAppBar(
            title: title,
            onBackPressed: () {
              context.router.pop();
            },
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                return Shimmer.fromColors(
                  baseColor: appColor.surfaceContainer,
                  highlightColor: appColor.surfaceContainerHigh,
                  child: Container(
                    decoration: BoxDecoration(
                      color: appColor.surfaceContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              }, childCount: 6),
            ),
          ),
        ],
      ),
    );
  }
}
