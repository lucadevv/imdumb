import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdumb/core/constants/app_strings.dart';
import 'package:imdumb/core/widgets/molecules/empty_state.dart';
import 'package:imdumb/core/widgets/molecules/error_state.dart';
import 'package:imdumb/core/widgets/molecules/movie_poster_card.dart';
import 'package:imdumb/core/widgets/molecules/shimmer_list.dart';
import 'package:imdumb/core/routes/app_router.gr.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
import 'package:imdumb/features/home/domain/entities/genre_entity.dart';
import 'package:imdumb/features/home/presentation/bloc/genres/genres_bloc.dart';
import 'package:imdumb/features/home/presentation/bloc/genre_movies/genre_movies_bloc.dart';
import 'package:imdumb/features/movies_list/domain/entities/movie_list_type.dart';
import 'package:imdumb/core/services/firebase/analytics_service.dart';
import 'package:imdumb/main.dart';

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
          delegate: SliverChildBuilderDelegate((context, index) {
            final genre = state.genres[index];
            return _GenreMoviesSectionContent(
              genre: genre,
              key: ValueKey(genre.id),
            );
          }, childCount: state.genres.length),
        );
      },
    );
  }
}

class _GenreMoviesSectionContent extends StatefulWidget {
  final GenreEntity genre;

  const _GenreMoviesSectionContent({super.key, required this.genre});

  @override
  State<_GenreMoviesSectionContent> createState() =>
      _GenreMoviesSectionContentState();
}

class _GenreMoviesSectionContentState
    extends State<_GenreMoviesSectionContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // Cargar películas del género cuando se inicializa
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final state = context.read<GenreMoviesBloc>().state;
      final movies = state.moviesByGenre[widget.genre.id];
      if (movies == null || movies.isEmpty) {
        if (!mounted) return;
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
                    key: Key('genre_${widget.genre.id}_view_more_button'),
                    onPressed: () async {
                      // Guardar el router antes del await para evitar usar context después de async gap
                      if (!mounted) return;
                      final router = context.router;
                      
                      // SOLID: Dependency Inversion Principle (DIP)
                      // El widget depende de la abstracción AnalyticsService, no de la implementación concreta.
                      try {
                        final analyticsService = getIt<AnalyticsService>();
                        await analyticsService.logEvent(
                          'view_more_clicked',
                          parameters: {
                            'type': 'genre',
                            'genre_id': widget.genre.id,
                            'genre_name': widget.genre.name,
                          },
                        );
                      } catch (e) {
                        // Silenciar errores de analytics para no afectar la experiencia del usuario
                        debugPrint('Error al registrar analytics: $e');
                      }

                      if (!mounted) return;
                      router.push(
                        MoviesListRoute(
                          type: MovieListType.genre,
                          genreId: widget.genre.id,
                          genreName: widget.genre.name,
                        ),
                      );
                    },
                    child: const Text(AppStrings.viewMore),
                  ),
                ],
              ),
            ),
            if (genreState == GenreMovieStatus.loading && movies.isEmpty)
              const ShimmerList()
            else if (genreState == GenreMovieStatus.failure && movies.isEmpty)
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ErrorState(
                  errorMessage: errorMessage ?? 'Error al cargar las películas',
                ),
              )
            else if (movies.isEmpty)
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: EmptyState(message: 'No hay películas disponibles'),
              )
            else
              SizedBox(
                height: 280,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  cacheExtent: 500,
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
                    return RepaintBoundary(
                      child: MoviePosterCard(movie: movie),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
