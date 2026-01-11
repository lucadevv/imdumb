class MovieDetailDbModel {
  final int? id;
  final String? title;
  final String? overview;
  final double? voteAverage;
  final int? voteCount;
  final String? releaseDate;
  final String? backdropPath;
  final String? posterPath;
  final int? runtime;
  final List<Map<String, dynamic>>? genres;

  MovieDetailDbModel({
    this.id,
    this.title,
    this.overview,
    this.voteAverage,
    this.voteCount,
    this.releaseDate,
    this.backdropPath,
    this.posterPath,
    this.runtime,
    this.genres,
  });

  factory MovieDetailDbModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailDbModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      overview: json['overview'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int?,
      releaseDate: json['release_date'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      posterPath: json['poster_path'] as String?,
      runtime: json['runtime'] as int?,
      genres: json['genres'] != null
          ? (json['genres'] as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'release_date': releaseDate,
      'backdrop_path': backdropPath,
      'poster_path': posterPath,
      'runtime': runtime,
      'genres': genres,
    };
  }
}
