part of 'home_bloc.dart';

enum PopularMovieState { initial, loading, success, failure }

abstract class HomeEffect extends Equatable {
  const HomeEffect();
}

class HomeState extends Equatable {
  final List<PopularMovieEntity> listMovie;
  final PopularMovieState popularMovieState;
  final List<PopularMovieEntity> listNowPlayingMovie;
  final PopularMovieState nowPlayingMovieState;
  final int nowPlayingPage;
  final bool hasMoreNowPlayingMovies;
  final List<PopularMovieEntity> listTopRatedMovie;
  final PopularMovieState topRatedMovieState;
  final int topRatedPage;
  final bool hasMoreTopRatedMovies;
  final List<GenreEntity> genres;
  final PopularMovieState genresState;
  final Map<int, List<PopularMovieEntity>> moviesByGenre;
  final Map<int, PopularMovieState> genreMovieStates;
  final Map<int, int> genrePages;
  final Map<int, bool> hasMoreByGenre;
  final Map<int, String?> genreErrors;
  final HomeEffect? homeEffect;
  final String? errorMessage;
  final String? nowPlayingErrorMessage;
  final String? topRatedErrorMessage;
  final String? genresErrorMessage;

  const HomeState({
    required this.listMovie,
    required this.popularMovieState,
    required this.listNowPlayingMovie,
    required this.nowPlayingMovieState,
    required this.nowPlayingPage,
    required this.hasMoreNowPlayingMovies,
    required this.listTopRatedMovie,
    required this.topRatedMovieState,
    required this.topRatedPage,
    required this.hasMoreTopRatedMovies,
    required this.genres,
    required this.genresState,
    required this.moviesByGenre,
    required this.genreMovieStates,
    required this.genrePages,
    required this.hasMoreByGenre,
    required this.genreErrors,
    this.homeEffect,
    this.errorMessage,
    this.nowPlayingErrorMessage,
    this.topRatedErrorMessage,
    this.genresErrorMessage,
  });

  HomeState copyWith({
    List<PopularMovieEntity>? listMovie,
    PopularMovieState? popularMovieState,
    List<PopularMovieEntity>? listNowPlayingMovie,
    PopularMovieState? nowPlayingMovieState,
    int? nowPlayingPage,
    bool? hasMoreNowPlayingMovies,
    List<PopularMovieEntity>? listTopRatedMovie,
    PopularMovieState? topRatedMovieState,
    int? topRatedPage,
    bool? hasMoreTopRatedMovies,
    List<GenreEntity>? genres,
    PopularMovieState? genresState,
    Map<int, List<PopularMovieEntity>>? moviesByGenre,
    Map<int, PopularMovieState>? genreMovieStates,
    Map<int, int>? genrePages,
    Map<int, bool>? hasMoreByGenre,
    Map<int, String?>? genreErrors,
    HomeEffect? homeEffect,
    String? errorMessage,
    String? nowPlayingErrorMessage,
    String? topRatedErrorMessage,
    String? genresErrorMessage,
  }) =>
      HomeState(
        listMovie: listMovie ?? this.listMovie,
        popularMovieState: popularMovieState ?? this.popularMovieState,
        listNowPlayingMovie: listNowPlayingMovie ?? this.listNowPlayingMovie,
        nowPlayingMovieState: nowPlayingMovieState ?? this.nowPlayingMovieState,
        nowPlayingPage: nowPlayingPage ?? this.nowPlayingPage,
        hasMoreNowPlayingMovies:
            hasMoreNowPlayingMovies ?? this.hasMoreNowPlayingMovies,
        listTopRatedMovie: listTopRatedMovie ?? this.listTopRatedMovie,
        topRatedMovieState: topRatedMovieState ?? this.topRatedMovieState,
        topRatedPage: topRatedPage ?? this.topRatedPage,
        hasMoreTopRatedMovies: hasMoreTopRatedMovies ?? this.hasMoreTopRatedMovies,
        genres: genres ?? this.genres,
        genresState: genresState ?? this.genresState,
        moviesByGenre: moviesByGenre ?? this.moviesByGenre,
        genreMovieStates: genreMovieStates ?? this.genreMovieStates,
        genrePages: genrePages ?? this.genrePages,
        hasMoreByGenre: hasMoreByGenre ?? this.hasMoreByGenre,
        genreErrors: genreErrors ?? this.genreErrors,
        errorMessage: errorMessage ?? this.errorMessage,
        nowPlayingErrorMessage:
            nowPlayingErrorMessage ?? this.nowPlayingErrorMessage,
        topRatedErrorMessage: topRatedErrorMessage ?? this.topRatedErrorMessage,
        genresErrorMessage: genresErrorMessage ?? this.genresErrorMessage,
        homeEffect: homeEffect ?? this.homeEffect,
      );

  factory HomeState.initial() => HomeState(
        listMovie: [],
        popularMovieState: PopularMovieState.initial,
        listNowPlayingMovie: [],
        nowPlayingMovieState: PopularMovieState.initial,
        nowPlayingPage: 1,
        hasMoreNowPlayingMovies: true,
        listTopRatedMovie: [],
        topRatedMovieState: PopularMovieState.initial,
        topRatedPage: 1,
        hasMoreTopRatedMovies: true,
        genres: [],
        genresState: PopularMovieState.initial,
        moviesByGenre: {},
        genreMovieStates: {},
        genrePages: {},
        hasMoreByGenre: {},
        genreErrors: {},
        errorMessage: null,
        nowPlayingErrorMessage: null,
        topRatedErrorMessage: null,
        genresErrorMessage: null,
        homeEffect: null,
      );

  @override
  List<Object?> get props => [
        listMovie,
        popularMovieState,
        listNowPlayingMovie,
        nowPlayingMovieState,
        nowPlayingPage,
        hasMoreNowPlayingMovies,
        listTopRatedMovie,
        topRatedMovieState,
        topRatedPage,
        hasMoreTopRatedMovies,
        genres,
        genresState,
        moviesByGenre,
        genreMovieStates,
        genrePages,
        hasMoreByGenre,
        genreErrors,
        errorMessage,
        nowPlayingErrorMessage,
        topRatedErrorMessage,
        genresErrorMessage,
        homeEffect,
      ];
}
