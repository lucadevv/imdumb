import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
import 'package:imdumb/features/movie_detail/domain/entities/movie_detail_entity.dart';

class EmptyImagesAppBar extends StatelessWidget {
  final MovieDetailEntity movieDetail;

  const EmptyImagesAppBar({
    super.key,
    required this.movieDetail,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        movieDetail.backdropUrlW1280 ?? movieDetail.backdropUrlW780;

    return Stack(
      fit: StackFit.expand,
      children: [
        if (imageUrl != null)
          CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                Container(color: context.appColor.surfaceContainer),
            errorWidget: (context, url, error) => Container(
              color: context.appColor.surfaceContainer,
              child: const Icon(Icons.movie, size: 64),
            ),
          )
        else
          Container(
            color: context.appColor.surfaceContainer,
            child: const Icon(Icons.movie, size: 64),
          ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.5),
                Colors.transparent,
                Colors.black.withValues(alpha: 0.7),
              ],
              stops: const [0.0, 0.4, 1.0],
            ),
          ),
        ),
      ],
    );
  }
}
