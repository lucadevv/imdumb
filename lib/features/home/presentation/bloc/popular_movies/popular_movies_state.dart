part of 'popular_movies_bloc.dart';

enum PopularMoviesStatus { initial, loading, success, failure }

class PopularMoviesState extends Equatable {
  final List<PopularMovieEntity> movies;
  final PopularMoviesStatus status;
  final String? errorMessage;

  const PopularMoviesState({
    required this.movies,
    required this.status,
    this.errorMessage,
  });

  PopularMoviesState copyWith({
    List<PopularMovieEntity>? movies,
    PopularMoviesStatus? status,
    String? errorMessage,
  }) =>
      PopularMoviesState(
        movies: movies ?? this.movies,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  factory PopularMoviesState.initial() => const PopularMoviesState(
        movies: [],
        status: PopularMoviesStatus.initial,
        errorMessage: null,
      );

  @override
  List<Object?> get props => [movies, status, errorMessage];
}
