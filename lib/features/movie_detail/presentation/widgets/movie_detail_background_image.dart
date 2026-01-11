import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
import 'package:imdumb/features/movie_detail/domain/entities/movie_detail_entity.dart';

class MovieDetailBackgroundImage extends StatelessWidget {
  final MovieDetailEntity? movieDetail;

  const MovieDetailBackgroundImage({super.key, this.movieDetail});

  @override
  Widget build(BuildContext context) {
    if (movieDetail == null) {
      return const SizedBox.shrink();
    }

    final imageUrl =
        movieDetail!.backdropUrlW1280 ?? movieDetail!.backdropUrlW780;

    final screenWidth = context.screenWidth;
    final screenHeight = context.screenHeight;
    final backgroundHeight = screenHeight;

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
              CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                width: screenWidth,
                height: backgroundHeight,
                placeholder: (context, url) =>
                    Container(color: context.appColor.surfaceContainer),
                errorWidget: (context, url, error) =>
                    Container(color: context.appColor.surfaceContainer),
              )
            else
              Container(color: context.appColor.surfaceContainer),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: context.appColor.surface.withValues(alpha: 0.9),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
