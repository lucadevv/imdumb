import 'package:flutter/material.dart';
import 'package:imdumb/core/constants/app_keys.dart';
import 'package:imdumb/core/widgets/molecules/movie_poster_card.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/movies_list/presentation/bloc/movies_list_bloc.dart';

/// Widget para el grid de películas optimizado
class MoviesListGrid extends StatelessWidget {
  final List<PopularMovieEntity> movies;
  final bool hasMore;
  final MoviesListStatus status;
  final int currentPage;
  final VoidCallback? onLoadMore;

  const MoviesListGrid({
    super.key,
    required this.movies,
    required this.hasMore,
    required this.status,
    required this.currentPage,
    this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverGrid(
        key: AppKeys.moviesListGrid,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index >= movies.length) {
              if (hasMore && onLoadMore != null) {
                onLoadMore?.call();
              }
              return const Center(child: CircularProgressIndicator());
            }

            final movie = movies[index];
            return RepaintBoundary(
              child: MoviePosterCard(movie: movie, titleMaxLines: 2),
            );
          },
          childCount:
              movies.length +
              (status == MoviesListStatus.loading && hasMore ? 1 : 0),
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: true,
          addSemanticIndexes: false,
        ),
      ),
    );
  }
}
