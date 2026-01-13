import 'dart:convert';
import 'package:imdumb/core/utils/helpers/date_parser.dart';

/// SOLID: Single Responsibility Principle (SRP)
///
/// Este modelo tiene una única responsabilidad: representar una película
/// tanto para serialización JSON como para almacenamiento local con Drift.
///
/// Patrón aplicado: Data Transfer Object (DTO)
/// Usado para transferir datos entre las capas de la aplicación (API, Base de Datos, Dominio).
class PopularMovieDbModel {
  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final DateTime? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  PopularMovieDbModel({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  PopularMovieDbModel copyWith({
    bool? adult,
    String? backdropPath,
    List<int>? genreIds,
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
  }) => PopularMovieDbModel(
    adult: adult ?? this.adult,
    backdropPath: backdropPath ?? this.backdropPath,
    genreIds: genreIds ?? this.genreIds,
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

  factory PopularMovieDbModel.fromJson(Map<String, dynamic> json) {
    final releaseDate = DateParser.parseReleaseDate(json["release_date"]);
    return PopularMovieDbModel(
      adult: json["adult"],
      backdropPath: json["backdrop_path"],
      genreIds: json["genre_ids"] == null
          ? []
          : List<int>.from(json["genre_ids"]!.map((x) => x)),
      id: json["id"],
      originalLanguage: json["original_language"],
      originalTitle: json["original_title"],
      overview: json["overview"],
      popularity: json["popularity"]?.toDouble(),
      posterPath: json["poster_path"],
      releaseDate: releaseDate,
      title: json["title"],
      video: json["video"],
      voteAverage: json["vote_average"]?.toDouble(),
      voteCount: json["vote_count"],
    );
  }

  // Métodos helper para convertir genreIds a/desde JSON string (para Drift)
  String? get genreIdsAsJson {
    if (genreIds == null || genreIds!.isEmpty) return null;
    return jsonEncode(genreIds);
  }

  static List<int>? genreIdsFromJson(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) return null;
    try {
      final decoded = jsonDecode(jsonString) as List;
      return decoded.map((e) => e as int).toList();
    } catch (e) {
      return null;
    }
  }
}
