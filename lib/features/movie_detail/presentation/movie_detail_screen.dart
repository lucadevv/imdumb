import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
import 'package:imdumb/features/movie_detail/domain/entities/cast_entity.dart';
import 'package:imdumb/features/movie_detail/domain/entities/movie_detail_entity.dart';
import 'package:imdumb/features/movie_detail/domain/entities/movie_image_entity.dart';
import 'package:imdumb/features/movie_detail/domain/use_cases/fetch_movie_credits_usecase.dart';
import 'package:imdumb/features/movie_detail/domain/use_cases/fetch_movie_detail_usecase.dart';
import 'package:imdumb/features/movie_detail/domain/use_cases/fetch_movie_images_usecase.dart';
import 'package:imdumb/features/movie_detail/presentation/bloc/movie_detail_bloc.dart';
import 'package:imdumb/features/movie_detail/presentation/widgets/movie_detail_background_image.dart';
import 'package:imdumb/main.dart';

@RoutePage()
class MovieDetailScreen extends StatefulWidget implements AutoRouteWrapper {
  final int movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieDetailBloc(
        fetchMovieDetailUsecase: getIt<FetchMovieDetailUsecase>(),
        fetchMovieImagesUsecase: getIt<FetchMovieImagesUsecase>(),
        fetchMovieCreditsUsecase: getIt<FetchMovieCreditsUsecase>(),
        movieId: movieId,
      )..add(const FetchMovieDetailEvent()),
      child: this,
    );
  }
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _showRecommendationModal() {
    final state = context.read<MovieDetailBloc>().state;
    final movieDetail = state.movieDetail;

    if (movieDetail == null) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _RecommendationModal(
        movieDetail: movieDetail,
        commentController: _commentController,
        onConfirm: () {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('¡Recomendación enviada con éxito!'),
              backgroundColor: context.appColor.primary,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
          _commentController.clear();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state.status == MovieDetailStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == MovieDetailStatus.failure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.errorMessage ?? 'Error al cargar el detalle',
                    style: TextStyle(color: context.appColor.error),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<MovieDetailBloc>().add(
                        const FetchMovieDetailEvent(),
                      );
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          final movieDetail = state.movieDetail;
          if (movieDetail == null) {
            return const Center(child: Text('No hay información disponible'));
          }

          return Stack(
            children: [
              MovieDetailBackgroundImage(movieDetail: movieDetail),
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text(
                      movieDetail.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        context.router.pop();
                      },
                    ),
                    floating: true,
                    pinned: true,
                    expandedHeight: context.screenHeight * 0.4,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    flexibleSpace: state.images.isNotEmpty
                        ? FlexibleSpaceBar(
                            background: _ImagesCarouselAppBar(
                              images: state.images,
                            ),
                          )
                        : FlexibleSpaceBar(
                            background: _EmptyImagesAppBar(
                              movieDetail: movieDetail,
                            ),
                          ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movieDetail.title,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              const SizedBox(width: 4),
                              Text(
                                movieDetail.formattedVoteAverage,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(width: 16),
                              if (movieDetail.runtime != null)
                                Text(
                                  movieDetail.formattedRuntime,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                            ],
                          ),
                          if (movieDetail.formattedGenres.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text(
                              movieDetail.formattedGenres,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                          const SizedBox(height: 16),
                          Text(
                            'Descripción',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            movieDetail.overview,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          if (state.casts.isNotEmpty) ...[
                            const SizedBox(height: 24),
                            Text(
                              'Elenco',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.only(right: 12),
                                itemCount: state.casts.length,
                                itemBuilder: (context, index) {
                                  final cast = state.casts[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: _CastCard(cast: cast),
                                  );
                                },
                              ),
                            ),
                          ],
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _showRecommendationModal,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Recomendar'),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ImagesCarouselAppBar extends StatelessWidget {
  final List<MovieImageEntity> images;

  const _ImagesCarouselAppBar({required this.images});

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
                      placeholder: (context, url) => Container(
                        color: context.appColor.surfaceContainer,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: context.appColor.surfaceContainer,
                        child: const Icon(Icons.image, size: 64),
                      ),
                    )
                  : Container(
                      color: context.appColor.surfaceContainer,
                      child: const Icon(Icons.image, size: 64),
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

class _EmptyImagesAppBar extends StatelessWidget {
  final MovieDetailEntity movieDetail;

  const _EmptyImagesAppBar({required this.movieDetail});

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

class _CastCard extends StatelessWidget {
  final CastEntity cast;

  const _CastCard({required this.cast});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 100,
              height: 100,
              color: context.appColor.surfaceContainer,
              child: cast.profileUrlW185 != null
                  ? CachedNetworkImage(
                      imageUrl: cast.profileUrlW185!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.person),
                    )
                  : const Icon(Icons.person, size: 48),
            ),
          ),
          const SizedBox(height: 6),
          Flexible(
            child: Text(
              cast.name,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (cast.character != null) ...[
            const SizedBox(height: 2),
            Flexible(
              child: Text(
                cast.character!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.appColor.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _RecommendationModal extends StatelessWidget {
  final MovieDetailEntity movieDetail;
  final TextEditingController commentController;
  final VoidCallback onConfirm;

  const _RecommendationModal({
    required this.movieDetail,
    required this.commentController,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appColor.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: context.appColor.onSurfaceVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              movieDetail.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              movieDetail.overview,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: commentController,
              decoration: InputDecoration(
                labelText: 'Comentario',
                hintText: 'Escribe tu comentario...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onConfirm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Confirmar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
