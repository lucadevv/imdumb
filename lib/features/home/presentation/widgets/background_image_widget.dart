import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
import 'package:imdumb/core/widgets/atoms/opacity_overlay.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';

class BackgroundImageWidget extends StatelessWidget {
  final int currentIndex;
  final List<PopularMovieEntity> movies;

  const BackgroundImageWidget({
    super.key,
    required this.currentIndex,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    // Validar que tenemos películas y el índice es válido
    if (movies.isEmpty) {
      return const SizedBox.shrink();
    }

    // Asegurar que el índice esté dentro del rango válido
    final validIndex = currentIndex.clamp(0, movies.length - 1);
    final movie = movies[validIndex];
    final imageUrl = movie.backdropUrlW1280 ?? movie.backdropUrlW780;

    final screenWidth = context.screenWidth;
    final screenHeight = context.screenHeight;
    final backgroundHeight = screenHeight * 0.7;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SizedBox(
        height: backgroundHeight,
        width: screenWidth,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (imageUrl != null)
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: CachedNetworkImage(
                  key: ValueKey(imageUrl),
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  width: screenWidth,
                  height: backgroundHeight,
                  placeholder: (context, url) => SizedBox(
                    width: screenWidth,
                    height: backgroundHeight,
                    child: Container(color: context.appColor.surfaceContainer),
                  ),
                  errorWidget: (context, url, error) => SizedBox(
                    width: screenWidth,
                    height: backgroundHeight,
                    child: Container(color: context.appColor.surfaceContainer),
                  ),
                ),
              )
            else
              Container(color: context.appColor.surfaceContainer),
            Positioned.fill(
              child: OpacityOverlay(
                opacity: 0.01,
                color: Colors.black.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
