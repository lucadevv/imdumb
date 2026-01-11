import 'package:equatable/equatable.dart';
import 'package:imdumb/core/utils/extension/tmdb_image_extension.dart';

class CreditDetailEntity extends Equatable {
  final String id;
  final String? creditType;
  final String? department;
  final String? job;
  final String? mediaType;
  final CreditPersonEntity? person;
  final CreditMediaEntity? media;

  const CreditDetailEntity({
    required this.id,
    this.creditType,
    this.department,
    this.job,
    this.mediaType,
    this.person,
    this.media,
  });

  @override
  List<Object?> get props => [
        id,
        creditType,
        department,
        job,
        mediaType,
        person,
        media,
      ];

  @override
  bool get stringify => true;
}

class CreditPersonEntity extends Equatable {
  final int id;
  final String name;
  final String? originalName;
  final String? profilePath;
  final String? knownForDepartment;
  final double? popularity;

  const CreditPersonEntity({
    required this.id,
    required this.name,
    this.originalName,
    this.profilePath,
    this.knownForDepartment,
    this.popularity,
  });

  String? get profileUrlW185 => profilePath.tmdbW185;

  @override
  List<Object?> get props => [
        id,
        name,
        originalName,
        profilePath,
        knownForDepartment,
        popularity,
      ];

  @override
  bool get stringify => true;
}

class CreditMediaEntity extends Equatable {
  final int id;
  final String? name;
  final String? title;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final String? mediaType;
  final double? voteAverage;
  final int? voteCount;
  final String? releaseDate;
  final String? firstAirDate;
  final String? character;

  const CreditMediaEntity({
    required this.id,
    this.name,
    this.title,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.mediaType,
    this.voteAverage,
    this.voteCount,
    this.releaseDate,
    this.firstAirDate,
    this.character,
  });

  String? get posterUrlW342 => posterPath.tmdbW342;
  String? get backdropUrlW780 => backdropPath.tmdbBackdropW780;

  String get displayTitle => title ?? name ?? 'Sin título';
  String? get displayDate => releaseDate ?? firstAirDate;

  @override
  List<Object?> get props => [
        id,
        name,
        title,
        overview,
        posterPath,
        backdropPath,
        mediaType,
        voteAverage,
        voteCount,
        releaseDate,
        firstAirDate,
        character,
      ];

  @override
  bool get stringify => true;
}
