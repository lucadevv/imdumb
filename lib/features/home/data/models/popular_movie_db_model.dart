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

  factory PopularMovieDbModel.fromJson(Map<String, dynamic> json) =>
      PopularMovieDbModel(
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
        releaseDate: _parseReleaseDate(json["release_date"]),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  static DateTime? _parseReleaseDate(dynamic releaseDate) {
    if (releaseDate == null) return null;
    if (releaseDate is! String) return null;
    if (releaseDate.isEmpty) return null;
    try {
      return DateTime.parse(releaseDate);
    } catch (e) {
      return null;
    }
  }
}
