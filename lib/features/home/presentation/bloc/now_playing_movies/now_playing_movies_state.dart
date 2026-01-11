part of 'now_playing_movies_bloc.dart';

enum NowPlayingMoviesStatus { initial, loading, success, failure }

class NowPlayingMoviesState extends Equatable {
  final List<PopularMovieEntity> movies;
  final NowPlayingMoviesStatus status;
  final int page;
  final bool hasMore;
  final String? errorMessage;

  const NowPlayingMoviesState({
    required this.movies,
    required this.status,
    required this.page,
    required this.hasMore,
    this.errorMessage,
  });

  NowPlayingMoviesState copyWith({
    List<PopularMovieEntity>? movies,
    NowPlayingMoviesStatus? status,
    int? page,
    bool? hasMore,
    String? errorMessage,
  }) =>
      NowPlayingMoviesState(
        movies: movies ?? this.movies,
        status: status ?? this.status,
        page: page ?? this.page,
        hasMore: hasMore ?? this.hasMore,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  factory NowPlayingMoviesState.initial() => const NowPlayingMoviesState(
        movies: [],
        status: NowPlayingMoviesStatus.initial,
        page: 1,
        hasMore: true,
        errorMessage: null,
      );

  @override
  List<Object?> get props => [movies, status, page, hasMore, errorMessage];
}
