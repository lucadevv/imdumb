import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdumb/core/widgets/molecules/movie_poster_card.dart';
import 'package:imdumb/core/widgets/molecules/shimmer_list.dart';
import 'package:imdumb/core/routes/app_router.gr.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
import 'package:imdumb/features/home/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:imdumb/features/movies_list/domain/entities/movie_list_type.dart';

class TopRatedMoviesSection extends StatefulWidget {
  const TopRatedMoviesSection({super.key});

  @override
  State<TopRatedMoviesSection> createState() => _TopRatedMoviesSectionState();
}

class _TopRatedMoviesSectionState extends State<TopRatedMoviesSection> {
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
      final state = context.read<TopRatedMoviesBloc>().state;
      if (state.hasMore && state.status != TopRatedMoviesStatus.loading) {
        context.read<TopRatedMoviesBloc>().add(
          FetchTopRatedMoviesEvent(page: state.page + 1, isLoadMore: true),
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
    return BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
      builder: (context, state) {
        return SliverToBoxAdapter(
          child: Column(
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
                    const Text(
                      'Top Rated',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.router.push(
                          MoviesListRoute(type: MovieListType.topRated),
                        );
                      },
                      child: const Text('Ver más'),
                    ),
                  ],
                ),
              ),
              if (state.status == TopRatedMoviesStatus.loading &&
                  state.movies.isEmpty)
                const ShimmerList()
              else if (state.status == TopRatedMoviesStatus.failure &&
                  state.movies.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Center(
                    child: Text(
                      state.errorMessage ?? 'Error al cargar las películas',
                      style: TextStyle(color: context.appColor.error),
                    ),
                  ),
                )
              else if (state.movies.isEmpty)
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
                        state.movies.length +
                        (state.status == TopRatedMoviesStatus.loading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= state.movies.length) {
                        return const SizedBox(
                          width: 160,
                          height: 280,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      final movie = state.movies[index];
                      return MoviePosterCard(movie: movie);
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
