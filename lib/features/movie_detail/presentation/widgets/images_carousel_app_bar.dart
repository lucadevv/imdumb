import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
import 'package:imdumb/features/movie_detail/domain/entities/movie_image_entity.dart';
import 'package:shimmer/shimmer.dart';

class ImagesCarouselAppBar extends StatelessWidget {
  final List<MovieImageEntity> images;

  const ImagesCarouselAppBar({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final expandedHeight = screenHeight * 0.5;

    return Stack(
      fit: StackFit.expand,
      children: [
        CarouselSlider.builder(
          itemCount: images.length,
          options: CarouselOptions(
            height: expandedHeight,
            aspectRatio: 16 / 9,
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            pageViewKey: const PageStorageKey('movie_images'),
          ),
          itemBuilder: (context, index, realIndex) {
            final image = images[index];
            final imageUrl = image.imageUrlW1280 ?? image.imageUrlW780;
            return SizedBox(
              width: double.infinity,
              child: imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => SizedBox.expand(
                        child: Shimmer.fromColors(
                          baseColor: context.appColor.surfaceContainer,
                          highlightColor: context.appColor.surfaceContainerHigh,
                          child: Container(
                            color: context.appColor.surfaceContainer,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => SizedBox.expand(
                        child: Container(
                          color: context.appColor.surfaceContainer,
                          child: const Icon(Icons.image, size: 64),
                        ),
                      ),
                    )
                  : SizedBox.expand(
                      child: Container(
                        color: context.appColor.surfaceContainer,
                        child: const Icon(Icons.image, size: 64),
                      ),
                    ),
            );
          },
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
