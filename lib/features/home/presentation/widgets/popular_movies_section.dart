import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/home/presentation/bloc/bloc/home_bloc.dart';

class PopularMoviesSection extends StatefulWidget {
  const PopularMoviesSection({super.key});

  @override
  State<PopularMoviesSection> createState() => _PopularMoviesSectionState();
}

class _PopularMoviesSectionState extends State<PopularMoviesSection> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    final carouselHeight = (screenWidth * 0.8) * (9 / 16) * 1.25;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Text(
                  'Películas Populares',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ),
              if (state.popularMovieState == PopularMovieState.loading)
                _ShimmerCarousel(height: carouselHeight)
              else if (state.popularMovieState == PopularMovieState.failure)
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Center(
                    child: Text(
                      state.errorMessage ?? 'Error al cargar las películas',
                      style: TextStyle(color: context.appColor.error),
                    ),
                  ),
                )
              else if (state.listMovie.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Center(child: Text('No hay películas disponibles')),
                )
              else
                Column(
                  children: [
                    CarouselSlider.builder(
                      carouselController: _carouselController,
                      itemCount: state.listMovie.length,
                      options: CarouselOptions(
                        height: carouselHeight,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.9,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(
                          milliseconds: 800,
                        ),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.1,
                        scrollDirection: Axis.horizontal,
                      ),
                      itemBuilder: (context, index, realIndex) {
                        final movie = state.listMovie[index];
                        return _MovieCard(movie: movie);
                      },
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}

class _ShimmerCarousel extends StatelessWidget {
  final double height;

  const _ShimmerCarousel({required this.height});

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColor;
    final screenWidth = context.screenWidth;
    final cardWidth = screenWidth * 0.8;

    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: cardWidth,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Shimmer.fromColors(
              baseColor: appColor.surfaceContainer,
              highlightColor: appColor.surfaceContainerHigh,
              child: Container(
                decoration: BoxDecoration(
                  color: appColor.surfaceContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  final PopularMovieEntity movie;

  const _MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (movie.backdropUrlW780 != null)
              CachedNetworkImage(
                imageUrl: movie.backdropUrlW780!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[900],
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[900],
                  child: const Icon(Icons.error),
                ),
              )
            else
              Container(
                color: Colors.grey[900],
                child: const Icon(Icons.movie, size: 64),
              ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          movie.formattedVoteAverage,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 16),
                        if (movie.releaseYear != null)
                          Text(
                            '${movie.releaseYear}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
