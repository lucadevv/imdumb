import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
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
    if (movies.isEmpty || currentIndex >= movies.length) {
      return const SizedBox.shrink();
    }

    final movie = movies[currentIndex];
    final imageUrl = movie.backdropUrlW1280 ?? movie.backdropUrlW780;

    final screenWidth = context.screenWidth;
    final screenHeight = context.screenHeight;
    final aspectRatio = screenHeight / screenWidth;
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
                  placeholder: (context, url) =>
                      Container(color: context.appColor.surfaceContainer),
                  errorWidget: (context, url, error) =>
                      Container(color: context.appColor.surfaceContainer),
                ),
              )
            else
              Container(color: context.appColor.surfaceContainer),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: const Color.fromARGB(
                    255,
                    55,
                    36,
                    36,
                  ).withValues(alpha: 0.3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
