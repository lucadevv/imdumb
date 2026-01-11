part of 'top_rated_movies_bloc.dart';

enum TopRatedMoviesStatus { initial, loading, success, failure }

class TopRatedMoviesState extends Equatable {
  final List<PopularMovieEntity> movies;
  final TopRatedMoviesStatus status;
  final int page;
  final bool hasMore;
  final String? errorMessage;

  const TopRatedMoviesState({
    required this.movies,
    required this.status,
    required this.page,
    required this.hasMore,
    this.errorMessage,
  });

  TopRatedMoviesState copyWith({
    List<PopularMovieEntity>? movies,
    TopRatedMoviesStatus? status,
    int? page,
    bool? hasMore,
    String? errorMessage,
  }) =>
      TopRatedMoviesState(
        movies: movies ?? this.movies,
        status: status ?? this.status,
        page: page ?? this.page,
        hasMore: hasMore ?? this.hasMore,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  factory TopRatedMoviesState.initial() => const TopRatedMoviesState(
        movies: [],
        status: TopRatedMoviesStatus.initial,
        page: 1,
        hasMore: true,
        errorMessage: null,
      );

  @override
  List<Object?> get props => [movies, status, page, hasMore, errorMessage];
}
