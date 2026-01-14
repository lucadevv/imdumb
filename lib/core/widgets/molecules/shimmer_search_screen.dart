import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:imdumb/core/constants/app_keys.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
import 'package:imdumb/features/search/presentation/widgets/search_app_bar.dart';

/// Molecule: ShimmerSearchScreen
///
/// Widget reutilizable para mostrar un shimmer loader que replica la estructura
/// de la pantalla de búsqueda. Incluye shimmer para:
/// - AppBar con campo de búsqueda
/// - Grid de resultados de búsqueda
///
/// SOLID: Single Responsibility Principle (SRP)
///
/// Este widget tiene una única responsabilidad: mostrar shimmer loaders
/// para la pantalla de búsqueda. Elimina duplicación de código
/// y proporciona una experiencia de usuario consistente durante la carga.
///
/// Patrón aplicado: Reusable Component (Atomic Design - Molecule)
class ShimmerSearchScreen extends StatelessWidget {
  const ShimmerSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColor;
    final searchController = TextEditingController();

    return Scaffold(
      body: CustomScrollView(
        key: AppKeys.searchScrollView,
        slivers: [
          SearchAppBar(
            searchController: searchController,
            onQueryChanged: (_) {},
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
