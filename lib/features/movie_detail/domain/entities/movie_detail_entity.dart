import 'package:equatable/equatable.dart';
import 'package:imdumb/core/utils/extension/tmdb_image_extension.dart';

class MovieDetailEntity extends Equatable {
  final int id;
  final String title;
  final String overview;
  final double voteAverage;
  final int voteCount;
  final DateTime? releaseDate;
  final String? backdropPath;
  final String? posterPath;
  final int? runtime;
  final List<String> genres;

  const MovieDetailEntity({
    required this.id,
    required this.title,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    this.releaseDate,
    this.backdropPath,
    this.posterPath,
    this.runtime,
    this.genres = const [],
  });

  String? get backdropUrlW780 => backdropPath.tmdbBackdropW780;
  String? get backdropUrlW1280 => backdropPath.tmdbBackdropW1280;
  String? get posterUrlW780 => posterPath.tmdbW780;

  String get formattedVoteAverage => voteAverage.toStringAsFixed(1);

  String get formattedRuntime {
    if (runtime == null) return 'N/A';
    final hours = runtime! ~/ 60;
    final minutes = runtime! % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }

  String get formattedGenres => genres.join(', ');

  @override
  List<Object?> get props => [
        id,
        title,
        overview,
        voteAverage,
        voteCount,
        releaseDate,
        backdropPath,
        posterPath,
        runtime,
        genres,
      ];

  @override
  bool get stringify => true;
}
