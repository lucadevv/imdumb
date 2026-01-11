import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:imdumb/core/routes/app_router.gr.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/home/domain/entities/genre_entity.dart';
import 'package:imdumb/features/home/presentation/bloc/genres/genres_bloc.dart';
import 'package:imdumb/features/home/presentation/bloc/genre_movies/genre_movies_bloc.dart';
import 'package:imdumb/features/movies_list/domain/entities/movie_list_type.dart';

class GenreMoviesSections extends StatelessWidget {
  const GenreMoviesSections({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenresBloc, GenresState>(
      builder: (context, state) {
        if (state.status == GenresStatus.loading) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        if (state.status == GenresStatus.failure) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Text(
                  state.errorMessage ?? 'Error al cargar los géneros',
                  style: TextStyle(color: context.appColor.error),
                ),
              ),
            ),
          );
        }

        if (state.genres.isEmpty) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final genre = state.genres[index];
              return _GenreMoviesSectionContent(
                genre: genre,
                key: ValueKey(genre.id),
              );
            },
            childCount: state.genres.length,
          ),
        );
      },
    );
  }
}

class _GenreMoviesSectionContent extends StatefulWidget {
  final GenreEntity genre;

  const _GenreMoviesSectionContent({super.key, required this.genre});

  @override
  State<_GenreMoviesSectionContent> createState() => _GenreMoviesSectionContentState();
}

class _GenreMoviesSectionContentState extends State<_GenreMoviesSectionContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // Cargar películas del género cuando se inicializa
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<GenreMoviesBloc>().state;
      final movies = state.moviesByGenre[widget.genre.id];
      if (movies == null || movies.isEmpty) {
        context.read<GenreMoviesBloc>().add(
          FetchMoviesByGenreEvent(
            genreId: widget.genre.id,
            page: 1,
            isLoadMore: false,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      final state = context.read<GenreMoviesBloc>().state;
      final genreState =
          state.movieStates[widget.genre.id] ?? GenreMovieStatus.initial;
      final hasMore = state.hasMore[widget.genre.id] ?? false;
      final currentPage = state.pages[widget.genre.id] ?? 1;

      if (hasMore && genreState != GenreMovieStatus.loading) {
        context.read<GenreMoviesBloc>().add(
          FetchMoviesByGenreEvent(
            genreId: widget.genre.id,
            page: currentPage + 1,
            isLoadMore: true,
          ),
        );
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    final delta = 200.0;
    return currentScroll >= (maxScroll - delta);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenreMoviesBloc, GenreMoviesState>(
      builder: (context, state) {
        final movies = state.moviesByGenre[widget.genre.id] ?? [];
        final genreState =
            state.movieStates[widget.genre.id] ?? GenreMovieStatus.initial;
        final errorMessage = state.errors[widget.genre.id];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.genre.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.router.push(
                        MoviesListRoute(
                          type: MovieListType.genre,
                          genreId: widget.genre.id,
                          genreName: widget.genre.name,
                        ),
                      );
                    },
                    child: const Text('Ver más'),
                  ),
                ],
              ),
            ),
              if (genreState == GenreMovieStatus.loading && movies.isEmpty)
                const _GenreShimmerList()
              else if (genreState == GenreMovieStatus.failure &&
                  movies.isEmpty)
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Center(
                  child: Text(
                    errorMessage ?? 'Error al cargar las películas',
                    style: TextStyle(color: context.appColor.error),
                  ),
                ),
              )
            else if (movies.isEmpty)
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Center(child: Text('No hay películas disponibles')),
              )
            else
              SizedBox(
                height: 280,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount:
                        movies.length +
                        (genreState == GenreMovieStatus.loading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= movies.length) {
                      return const SizedBox(
                        width: 160,
                        height: 280,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    final movie = movies[index];
                    return _GenreMovieCard(movie: movie);
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}

class _GenreMovieCard extends StatelessWidget {
  final PopularMovieEntity movie;

  const _GenreMovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.push(MovieDetailRoute(movieId: movie.id));
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 160,
        height: 280,
        margin: const EdgeInsets.only(right: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (movie.posterThumbnail != null)
                    CachedNetworkImage(
                      imageUrl: movie.posterThumbnail!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: context.appColor.surfaceContainer,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: context.appColor.surfaceContainer,
                        child: const Icon(Icons.movie),
                      ),
                    )
                  else
                    Container(
                      color: context.appColor.surfaceContainer,
                      child: const Icon(Icons.movie, size: 48),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    movie.title,
                    style: TextStyle(
                      color: context.appColor.onSurface,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        movie.formattedVoteAverage,
                        style: TextStyle(
                          color: context.appColor.onSurfaceVariant,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}

class _GenreShimmerList extends StatelessWidget {
  const _GenreShimmerList();

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColor;

    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 160,
            height: 280,
            margin: const EdgeInsets.only(right: 12.0),
            child: Shimmer.fromColors(
              baseColor: appColor.surfaceContainer,
              highlightColor: appColor.surfaceContainerHigh,
              child: Container(
                decoration: BoxDecoration(
                  color: appColor.surfaceContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
