import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdumb/core/constants/app_keys.dart';
import 'package:imdumb/features/movies_list/domain/entities/movie_list_type.dart';
import 'package:imdumb/features/movies_list/domain/use_cases/fetch_movies_list_usecase.dart';
import 'package:imdumb/features/movies_list/presentation/bloc/movies_list_bloc.dart';
import 'package:imdumb/features/movies_list/presentation/widgets/movies_list_app_bar.dart';
import 'package:imdumb/features/movies_list/presentation/widgets/movies_list_empty_state.dart';
import 'package:imdumb/features/movies_list/presentation/widgets/movies_list_error_state.dart';
import 'package:imdumb/features/movies_list/presentation/widgets/movies_list_grid.dart';
import 'package:imdumb/core/services/firebase/analytics_service.dart';
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
    _trackScreenView();
  }

  Future<void> _trackScreenView() async {
    try {
      final analyticsService = getIt<AnalyticsService>();
      await analyticsService.logScreenView(
        'movies_list_screen',
        parameters: {
          'type': widget.type.toString(),
          if (widget.genreId != null) 'genre_id': widget.genreId,
          if (widget.genreName != null) 'genre_name': widget.genreName,
        },
      );
    } catch (e) {
      // Silenciar errores de analytics para no afectar la experiencia del usuario
      debugPrint('Error al registrar analytics: $e');
    }
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
            return MoviesListErrorState(
              errorMessage: state.errorMessage,
              onRetry: () {
                context.read<MoviesListBloc>().add(
                      const FetchMoviesListEvent(),
                    );
              },
            );
          }

          if (state.movies.isEmpty) {
            return const MoviesListEmptyState();
          }

          return RefreshIndicator(
            key: AppKeys.moviesListRefreshIndicator,
            onRefresh: () async {
              context.read<MoviesListBloc>().add(
                const FetchMoviesListEvent(page: 1, isLoadMore: false),
              );
              // Esperar un poco para que el refresh se complete
              await Future.delayed(const Duration(milliseconds: 500));
            },
            child: CustomScrollView(
              key: AppKeys.moviesListScrollView,
              controller: _scrollController,
              slivers: [
                MoviesListAppBar(
                  title: widget.genreName ?? widget.type.title,
                  onBackPressed: () {
                    context.router.pop();
                  },
                ),
                MoviesListGrid(
                  movies: state.movies,
                  hasMore: state.hasMore,
                  status: state.status,
                  currentPage: state.page,
                  onLoadMore: () {
                    context.read<MoviesListBloc>().add(
                          FetchMoviesListEvent(
                            page: state.page + 1,
                            isLoadMore: true,
                          ),
                        );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
