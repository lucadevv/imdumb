import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdumb/core/widgets/molecules/movie_poster_card.dart';
import 'package:imdumb/core/widgets/molecules/shimmer_list.dart';
import 'package:imdumb/core/routes/app_router.gr.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
import 'package:imdumb/features/home/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:imdumb/features/movies_list/domain/entities/movie_list_type.dart';

class NowPlayingMoviesSection extends StatefulWidget {
  const NowPlayingMoviesSection({super.key});

  @override
  State<NowPlayingMoviesSection> createState() =>
      _NowPlayingMoviesSectionState();
}

class _NowPlayingMoviesSectionState extends State<NowPlayingMoviesSection> {
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
      final state = context.read<NowPlayingMoviesBloc>().state;
      if (state.hasMore && state.status != NowPlayingMoviesStatus.loading) {
        context.read<NowPlayingMoviesBloc>().add(
          FetchNowPlayingMoviesEvent(page: state.page + 1, isLoadMore: true),
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
    return BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
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
                      'En Cartelera',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.router.push(
                          MoviesListRoute(type: MovieListType.nowPlaying),
                        );
                      },
                      child: const Text('Ver más'),
                    ),
                  ],
                ),
              ),
              if (state.status == NowPlayingMoviesStatus.loading &&
                  state.movies.isEmpty)
                const ShimmerList()
              else if (state.status == NowPlayingMoviesStatus.failure &&
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
                        (state.status == NowPlayingMoviesStatus.loading
                            ? 1
                            : 0),
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
