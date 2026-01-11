part of 'movie_detail_bloc.dart';

enum MovieDetailStatus { initial, loading, success, failure }

class MovieDetailState extends Equatable {
  final MovieDetailEntity? movieDetail;
  final List<MovieImageEntity> images;
  final List<CastEntity> casts;
  final MovieDetailStatus status;
  final String? errorMessage;

  const MovieDetailState({
    this.movieDetail,
    this.images = const [],
    this.casts = const [],
    required this.status,
    this.errorMessage,
  });

  MovieDetailState copyWith({
    MovieDetailEntity? movieDetail,
    List<MovieImageEntity>? images,
    List<CastEntity>? casts,
    MovieDetailStatus? status,
    String? errorMessage,
  }) {
    return MovieDetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      images: images ?? this.images,
      casts: casts ?? this.casts,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory MovieDetailState.initial() => const MovieDetailState(
        status: MovieDetailStatus.initial,
        images: [],
        casts: [],
      );

  @override
  List<Object?> get props => [
        movieDetail,
        images,
        casts,
        status,
        errorMessage,
      ];
}
