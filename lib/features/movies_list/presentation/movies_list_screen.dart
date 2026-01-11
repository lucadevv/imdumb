import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdumb/core/routes/app_router.gr.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/movies_list/domain/entities/movie_list_type.dart';
import 'package:imdumb/features/movies_list/domain/use_cases/fetch_movies_list_usecase.dart';
import 'package:imdumb/features/movies_list/presentation/bloc/movies_list_bloc.dart';
import 'package:imdumb/main.dart';

@RoutePage()
class MoviesListScreen extends StatefulWidget implements AutoRouteWrapper {
  final MovieListType type;
  final int? genreId;
  final String? genreName;

  const MoviesListScreen({
    super.key,
    required this.type,
    this.genreId,
    this.genreName,
  });

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesListBloc(
        fetchMoviesListUsecase: getIt<FetchMoviesListUsecase>(),
        type: type,
        genreId: genreId,
      )..add(const FetchMoviesListEvent()),
      child: this,
    );
  }
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      final state = context.read<MoviesListBloc>().state;
      if (state.hasMore && state.status != MoviesListStatus.loading) {
        context.read<MoviesListBloc>().add(
          FetchMoviesListEvent(page: state.page + 1, isLoadMore: true),
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
    return Scaffold(
      body: BlocBuilder<MoviesListBloc, MoviesListState>(
        builder: (context, state) {
          if (state.status == MoviesListStatus.loading &&
              state.movies.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == MoviesListStatus.failure &&
              state.movies.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.errorMessage ?? 'Error al cargar las películas',
                    style: TextStyle(color: context.appColor.error),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<MoviesListBloc>().add(
                        const FetchMoviesListEvent(),
                      );
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          if (state.movies.isEmpty) {
            return Center(
              child: Text(
                'No hay películas disponibles',
                style: TextStyle(color: context.appColor.onSurface),
              ),
            );
          }

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                title: Text(widget.genreName ?? widget.type.title),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    context.router.pop();
                  },
                ),
                floating: true,
                pinned: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.appColor.surfaceContainer.withValues(
                          alpha: 0.9,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index >= state.movies.length) {
                        if (state.hasMore) {
                          context.read<MoviesListBloc>().add(
                            FetchMoviesListEvent(
                              page: state.page + 1,
                              isLoadMore: true,
                            ),
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      }

                      final movie = state.movies[index];
                      return _MovieGridCard(movie: movie);
                    },
                    childCount:
                        state.movies.length +
                        (state.status == MoviesListStatus.loading &&
                                state.hasMore
                            ? 1
                            : 0),
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

class _MovieGridCard extends StatelessWidget {
  final PopularMovieEntity movie;

  const _MovieGridCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.push(MovieDetailRoute(movieId: movie.id));
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
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
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
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
                      maxLines: 2,
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
