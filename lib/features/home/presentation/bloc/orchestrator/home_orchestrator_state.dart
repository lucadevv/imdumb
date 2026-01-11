part of 'home_orchestrator_bloc.dart';

abstract class HomeOrchestratorEffect extends Equatable {
  const HomeOrchestratorEffect();

  @override
  List<Object?> get props => [];
}

class LoadAllHomeDataEffect extends HomeOrchestratorEffect {
  const LoadAllHomeDataEffect();

  @override
  List<Object?> get props => [];
}

class HomeOrchestratorState extends Equatable {
  final PopularMoviesState popularMoviesState;
  final NowPlayingMoviesState nowPlayingMoviesState;
  final TopRatedMoviesState topRatedMoviesState;
  final GenresState genresState;
  final GenreMoviesState genreMoviesState;
  final HomeOrchestratorEffect? effect;

  const HomeOrchestratorState({
    required this.popularMoviesState,
    required this.nowPlayingMoviesState,
    required this.topRatedMoviesState,
    required this.genresState,
    required this.genreMoviesState,
    this.effect,
  });

  HomeOrchestratorState copyWith({
    PopularMoviesState? popularMoviesState,
    NowPlayingMoviesState? nowPlayingMoviesState,
    TopRatedMoviesState? topRatedMoviesState,
    GenresState? genresState,
    GenreMoviesState? genreMoviesState,
    HomeOrchestratorEffect? effect,
  }) =>
      HomeOrchestratorState(
        popularMoviesState:
            popularMoviesState ?? this.popularMoviesState,
        nowPlayingMoviesState:
            nowPlayingMoviesState ?? this.nowPlayingMoviesState,
        topRatedMoviesState:
            topRatedMoviesState ?? this.topRatedMoviesState,
        genresState: genresState ?? this.genresState,
        genreMoviesState: genreMoviesState ?? this.genreMoviesState,
        effect: effect ?? this.effect,
      );

  factory HomeOrchestratorState.initial() => HomeOrchestratorState(
        popularMoviesState: PopularMoviesState.initial(),
        nowPlayingMoviesState: NowPlayingMoviesState.initial(),
        topRatedMoviesState: TopRatedMoviesState.initial(),
        genresState: GenresState.initial(),
        genreMoviesState: GenreMoviesState.initial(),
        effect: null,
      );

  @override
  List<Object?> get props => [
        popularMoviesState,
        nowPlayingMoviesState,
        topRatedMoviesState,
        genresState,
        genreMoviesState,
        effect,
      ];
}
