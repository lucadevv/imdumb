import 'package:equatable/equatable.dart';
import 'package:imdumb/core/utils/extension/tmdb_image_extension.dart';

class PopularMovieEntity extends Equatable {
  final bool adult;
  final String? backdropPath;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final DateTime? releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  const PopularMovieEntity({
    required this.adult,
    this.backdropPath,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  String? get posterUrlW92 => posterPath.tmdbW92;
  String? get posterUrlW154 => posterPath.tmdbW154;
  String? get posterUrlW185 => posterPath.tmdbW185;
  String? get posterUrlW342 => posterPath.tmdbW342;
  String? get posterUrlW500 => posterPath.tmdbW500;
  String? get posterUrlW780 => posterPath.tmdbW780;
  String? get posterUrlOriginal => posterPath.tmdbOriginal;

  String? get backdropUrlW300 => backdropPath.tmdbBackdropW300;
  String? get backdropUrlW780 => backdropPath.tmdbBackdropW780;
  String? get backdropUrlW1280 => backdropPath.tmdbBackdropW1280;
  String? get backdropUrlOriginal => backdropPath.tmdbOriginal;

  String? get posterThumbnail => posterPath.asPosterThumbnail;
  String? get posterMedium => posterPath.asPosterMedium;
  String? get posterLarge => posterPath.asPosterLarge;

  String? get backdropSmall => backdropPath.tmdbBackdropW300;
  String? get backdropMedium => backdropPath.asBackdropMedium;
  String? get backdropLarge => backdropPath.asBackdropLarge;

  String? getCustomImageUrl(String size, {bool isBackdrop = false}) {
    return isBackdrop ? backdropPath.tmdbUrl(size) : posterPath.tmdbUrl(size);
  }

  String get formattedReleaseDate {
    if (releaseDate == null) return 'Fecha no disponible';
    return '${releaseDate!.day}/${releaseDate!.month}/${releaseDate!.year}';
  }

  int get ratingPercentage => (voteAverage * 10).toInt();

  String get formattedVoteAverage => voteAverage.toStringAsFixed(1);

  bool get isRecent {
    if (releaseDate == null) return false;
    final now = DateTime.now();
    final difference = now.difference(releaseDate!);
    return difference.inDays <= 90;
  }

  bool get isUpcoming {
    if (releaseDate == null) return false;
    final now = DateTime.now();
    return releaseDate!.isAfter(now);
  }

  int? get releaseYear => releaseDate?.year;

  @override
  List<Object?> get props => [
    id,
    adult,
    backdropPath,
    originalLanguage,
    originalTitle,
    overview,
    popularity,
    posterPath,
    releaseDate,
    title,
    video,
    voteAverage,
    voteCount,
  ];

  @override
  bool get stringify => true;

  PopularMovieEntity copyWith({
    bool? adult,
    String? backdropPath,
    int? id,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    DateTime? releaseDate,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) {
    return PopularMovieEntity(
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      id: id ?? this.id,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      releaseDate: releaseDate ?? this.releaseDate,
      title: title ?? this.title,
      video: video ?? this.video,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
    );
  }

  @override
  String toString() {
    return 'PopularMovieEntity{id: $id, title: $title, releaseDate: $releaseDate, voteAverage: $voteAverage}';
  }
}
