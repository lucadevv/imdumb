part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchAllPopularMovieEvent extends HomeEvent {
  const FetchAllPopularMovieEvent();
}

class FetchAllNowPlayingMovieEvent extends HomeEvent {
  final int page;
  final bool isLoadMore;

  const FetchAllNowPlayingMovieEvent({
    this.page = 1,
    this.isLoadMore = false,
  });

  @override
  List<Object> get props => [page, isLoadMore];
}

class FetchAllTopRatedMovieEvent extends HomeEvent {
  final int page;
  final bool isLoadMore;

  const FetchAllTopRatedMovieEvent({
    this.page = 1,
    this.isLoadMore = false,
  });

  @override
  List<Object> get props => [page, isLoadMore];
}

class FetchAllGenresEvent extends HomeEvent {
  const FetchAllGenresEvent();
}

class FetchMoviesByGenreEvent extends HomeEvent {
  final int genreId;
  final int page;
  final bool isLoadMore;

  const FetchMoviesByGenreEvent({
    required this.genreId,
    this.page = 1,
    this.isLoadMore = false,
  });

  @override
  List<Object> get props => [genreId, page, isLoadMore];
}
