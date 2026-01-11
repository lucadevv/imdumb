part of 'genre_movies_bloc.dart';

enum GenreMovieStatus { initial, loading, success, failure }

class GenreMoviesState extends Equatable {
  final Map<int, List<PopularMovieEntity>> moviesByGenre;
  final Map<int, GenreMovieStatus> movieStates;
  final Map<int, int> pages;
  final Map<int, bool> hasMore;
  final Map<int, String?> errors;

  const GenreMoviesState({
    required this.moviesByGenre,
    required this.movieStates,
    required this.pages,
    required this.hasMore,
    required this.errors,
  });

  GenreMoviesState copyWith({
    Map<int, List<PopularMovieEntity>>? moviesByGenre,
    Map<int, GenreMovieStatus>? movieStates,
    Map<int, int>? pages,
    Map<int, bool>? hasMore,
    Map<int, String?>? errors,
  }) =>
      GenreMoviesState(
        moviesByGenre: moviesByGenre ?? this.moviesByGenre,
        movieStates: movieStates ?? this.movieStates,
        pages: pages ?? this.pages,
        hasMore: hasMore ?? this.hasMore,
        errors: errors ?? this.errors,
      );

  factory GenreMoviesState.initial() => const GenreMoviesState(
        moviesByGenre: {},
        movieStates: {},
        pages: {},
        hasMore: {},
        errors: {},
      );

  @override
  List<Object?> get props => [
        moviesByGenre,
        movieStates,
        pages,
        hasMore,
        errors,
      ];
}
