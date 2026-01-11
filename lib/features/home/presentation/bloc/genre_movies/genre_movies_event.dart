part of 'genre_movies_bloc.dart';

abstract class GenreMoviesEvent extends Equatable {
  const GenreMoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchMoviesByGenreEvent extends GenreMoviesEvent {
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
