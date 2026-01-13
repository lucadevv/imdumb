part of 'home_orchestrator_bloc.dart';

abstract class HomeOrchestratorEvent extends Equatable {
  const HomeOrchestratorEvent();

  @override
  List<Object> get props => [];
}

class LoadAllHomeDataEvent extends HomeOrchestratorEvent {
  const LoadAllHomeDataEvent();
}

// Eventos internos para actualizar estados desde stream listeners
class PopularMoviesStateChangedEvent extends HomeOrchestratorEvent {
  final PopularMoviesState state;
  const PopularMoviesStateChangedEvent(this.state);

  @override
  List<Object> get props => [state];
}

class NowPlayingMoviesStateChangedEvent extends HomeOrchestratorEvent {
  final NowPlayingMoviesState state;
  const NowPlayingMoviesStateChangedEvent(this.state);

  @override
  List<Object> get props => [state];
}

class TopRatedMoviesStateChangedEvent extends HomeOrchestratorEvent {
  final TopRatedMoviesState state;
  const TopRatedMoviesStateChangedEvent(this.state);

  @override
  List<Object> get props => [state];
}

class GenresStateChangedEvent extends HomeOrchestratorEvent {
  final GenresState state;
  const GenresStateChangedEvent(this.state);

  @override
  List<Object> get props => [state];
}

class GenreMoviesStateChangedEvent extends HomeOrchestratorEvent {
  final GenreMoviesState state;
  const GenreMoviesStateChangedEvent(this.state);

  @override
  List<Object> get props => [state];
}
