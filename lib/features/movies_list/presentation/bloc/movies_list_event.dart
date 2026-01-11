part of 'movies_list_bloc.dart';

abstract class MoviesListEvent extends Equatable {
  const MoviesListEvent();

  @override
  List<Object> get props => [];
}

class FetchMoviesListEvent extends MoviesListEvent {
  final int page;
  final bool isLoadMore;

  const FetchMoviesListEvent({
    this.page = 1,
    this.isLoadMore = false,
  });

  @override
  List<Object> get props => [page, isLoadMore];
}
