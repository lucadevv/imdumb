part of 'search_bloc.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState extends Equatable {
  final List<PopularMovieEntity> movies;
  final SearchStatus status;
  final String? errorMessage;
  final String query;
  final int page;
  final bool hasMore;

  const SearchState({
    required this.movies,
    required this.status,
    this.errorMessage,
    required this.query,
    required this.page,
    required this.hasMore,
  });

  SearchState copyWith({
    List<PopularMovieEntity>? movies,
    SearchStatus? status,
    String? errorMessage,
    String? query,
    int? page,
    bool? hasMore,
  }) =>
      SearchState(
        movies: movies ?? this.movies,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        query: query ?? this.query,
        page: page ?? this.page,
        hasMore: hasMore ?? this.hasMore,
      );

  factory SearchState.initial() => const SearchState(
        movies: [],
        status: SearchStatus.initial,
        query: '',
        page: 1,
        hasMore: false,
        errorMessage: null,
      );

  @override
  List<Object?> get props => [movies, status, errorMessage, query, page, hasMore];
}
