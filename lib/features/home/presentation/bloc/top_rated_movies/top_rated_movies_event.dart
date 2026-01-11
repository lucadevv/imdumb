part of 'top_rated_movies_bloc.dart';

abstract class TopRatedMoviesEvent extends Equatable {
  const TopRatedMoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchTopRatedMoviesEvent extends TopRatedMoviesEvent {
  final int page;
  final bool isLoadMore;

  const FetchTopRatedMoviesEvent({
    this.page = 1,
    this.isLoadMore = false,
  });

  @override
  List<Object> get props => [page, isLoadMore];
}
