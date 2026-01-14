import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdumb/core/constants/app_keys.dart';
import 'package:imdumb/core/services/firebase/analytics_service.dart';
import 'package:imdumb/features/search/domain/use_cases/fetch_search_movies_usecase.dart';
import 'package:imdumb/features/search/presentation/bloc/search_bloc.dart';
import 'package:imdumb/features/search/presentation/widgets/search_app_bar.dart';
import 'package:imdumb/features/search/presentation/widgets/search_empty_state.dart';
import 'package:imdumb/features/search/presentation/widgets/search_error_state.dart';
import 'package:imdumb/features/search/presentation/widgets/search_grid.dart';
import 'package:imdumb/core/widgets/molecules/shimmer_search_screen.dart';
import 'package:imdumb/main.dart';

@RoutePage()
class SearchScreen extends StatefulWidget implements AutoRouteWrapper {
  const SearchScreen({super.key});

  static const Key screenKey = Key('search_screen');

  @override
  State<SearchScreen> createState() => _SearchScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(
        fetchSearchMoviesUsecase: getIt<FetchSearchMoviesUsecase>(),
      ),
      child: this,
    );
  }
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
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
      await analyticsService.logScreenView('search_screen');
    } catch (e) {
      // Silenciar errores de analytics para no afectar la experiencia del usuario
      debugPrint('Error al registrar analytics: $e');
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      final state = context.read<SearchBloc>().state;
      if (state.hasMore &&
          state.status != SearchStatus.loading &&
          state.query.isNotEmpty) {
        context.read<SearchBloc>().add(
          FetchSearchMoviesEvent(
            query: state.query,
            page: state.page + 1,
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
    return Scaffold(
      key: SearchScreen.screenKey,
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state.status == SearchStatus.loading && state.movies.isEmpty) {
            return const ShimmerSearchScreen();
          }

          return CustomScrollView(
            key: AppKeys.searchScrollView,
            controller: _scrollController,
            slivers: [
              SearchAppBar(
                searchController: _searchController,
                onQueryChanged: (value) {
                  context.read<SearchBloc>().add(
                    SearchQueryChangedEvent(query: value),
                  );
                },
                onBackPressed: () {
                  context.router.pop();
                },
              ),
              if (state.status == SearchStatus.failure && state.movies.isEmpty)
                SearchErrorState(
                  errorMessage: state.errorMessage,
                  onRetry: () {
                    if (state.query.isNotEmpty) {
                      context.read<SearchBloc>().add(
                        FetchSearchMoviesEvent(query: state.query),
                      );
                    }
                  },
                )
              else if (state.query.isEmpty &&
                  state.status == SearchStatus.initial)
                const SearchEmptyState(
                  message: 'Escribe para buscar películas...',
                )
              else if (state.movies.isEmpty &&
                  state.status == SearchStatus.success)
                const SearchEmptyState(message: 'No se encontraron películas')
              else
                SearchGrid(
                  movies: state.movies,
                  hasMore: state.hasMore,
                  status: state.status,
                  query: state.query,
                  currentPage: state.page,
                  onLoadMore: () {
                    context.read<SearchBloc>().add(
                      FetchSearchMoviesEvent(
                        query: state.query,
                        page: state.page + 1,
                        isLoadMore: true,
                      ),
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
