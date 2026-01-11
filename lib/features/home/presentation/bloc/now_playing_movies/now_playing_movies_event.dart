part of 'now_playing_movies_bloc.dart';

abstract class NowPlayingMoviesEvent extends Equatable {
  const NowPlayingMoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchNowPlayingMoviesEvent extends NowPlayingMoviesEvent {
  final int page;
  final bool isLoadMore;

  const FetchNowPlayingMoviesEvent({
    this.page = 1,
    this.isLoadMore = false,
  });

  @override
  List<Object> get props => [page, isLoadMore];
}
