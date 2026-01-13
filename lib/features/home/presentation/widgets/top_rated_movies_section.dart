import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdumb/core/constants/app_keys.dart';
import 'package:imdumb/core/constants/app_strings.dart';
import 'package:imdumb/core/widgets/molecules/movie_poster_card.dart';
import 'package:imdumb/core/widgets/molecules/shimmer_list.dart';
import 'package:imdumb/core/routes/app_router.gr.dart';
import 'package:imdumb/core/utils/extension/context_extension.dart';
import 'package:imdumb/features/home/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:imdumb/features/movies_list/domain/entities/movie_list_type.dart';
import 'package:imdumb/core/services/firebase/analytics_service.dart';
import 'package:imdumb/main.dart';

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
                    Text(
                      AppStrings.topRated,
                      key: AppKeys.topRatedSectionTitle,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      key: AppKeys.topRatedViewMoreButton,
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
                            parameters: {'type': 'top_rated'},
                          );
                        } catch (e) {
                          // Silenciar errores de analytics para no afectar la experiencia del usuario
                          debugPrint('Error al registrar analytics: $e');
                        }

                        if (!mounted) return;
                        router.push(
                          MoviesListRoute(type: MovieListType.topRated),
                        );
                      },
                      child: const Text(AppStrings.viewMore),
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
                    key: AppKeys.topRatedMoviesList,
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    cacheExtent: 500,
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
                      return RepaintBoundary(
                        child: MoviePosterCard(movie: movie),
                      );
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
