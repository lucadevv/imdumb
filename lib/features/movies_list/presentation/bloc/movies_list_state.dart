part of 'movies_list_bloc.dart';

enum MoviesListStatus { initial, loading, success, failure }

class MoviesListState extends Equatable {
  final List<PopularMovieEntity> movies;
  final MoviesListStatus status;
  final int page;
  final bool hasMore;
  final String? errorMessage;

  const MoviesListState({
    required this.movies,
    required this.status,
    required this.page,
    required this.hasMore,
    this.errorMessage,
  });

  MoviesListState copyWith({
    List<PopularMovieEntity>? movies,
    MoviesListStatus? status,
    int? page,
    bool? hasMore,
    String? errorMessage,
  }) =>
      MoviesListState(
        movies: movies ?? this.movies,
        status: status ?? this.status,
        page: page ?? this.page,
        hasMore: hasMore ?? this.hasMore,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  factory MoviesListState.initial() => const MoviesListState(
        movies: [],
        status: MoviesListStatus.initial,
        page: 1,
        hasMore: true,
        errorMessage: null,
      );

  @override
  List<Object?> get props => [movies, status, page, hasMore, errorMessage];
}
