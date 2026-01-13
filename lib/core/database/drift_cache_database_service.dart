import 'dart:convert';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/foundation.dart';
import 'package:imdumb/core/database/app_database.dart';
import 'package:imdumb/core/database/cache_database_service.dart';
import 'package:imdumb/core/utils/helpers/date_parser.dart';
import 'package:imdumb/features/home/data/models/popular_movie_db_model.dart';
import 'package:imdumb/features/home/data/models/genre_db_model.dart';

/// SOLID: Open/Closed Principle (OCP)
///
/// Esta implementación está abierta para extensión pero cerrada para modificación.
/// Es un wrapper de AppDatabase (Drift) que implementa CacheDatabaseService.
/// Permite mantener compatibilidad con la implementación anterior mientras
/// se puede cambiar fácilmente a otra implementación (SQLite) sin modificar el código cliente.
///
/// Patrón aplicado: Adapter Pattern
/// Adapta la interfaz de AppDatabase (Drift) a la interfaz CacheDatabaseService.
class DriftCacheDatabaseService implements CacheDatabaseService {
  final AppDatabase _database;

  DriftCacheDatabaseService({required AppDatabase database})
      : _database = database;

  // Helper methods para conversión de genreIds
  String? _genreIdsToJson(List<int>? genreIds) {
    if (genreIds == null || genreIds.isEmpty) return null;
    return jsonEncode(genreIds);
  }

  List<int>? _genreIdsFromJson(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) return null;
    try {
      final decoded = jsonDecode(jsonString) as List;
      return decoded.map((e) => e as int).toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cachePopularMovies(List<PopularMovieDbModel> movies) async {
    try {
      await _database.delete(_database.popularMoviesTable).go();
      await _database.batch((batch) {
        for (final movie in movies) {
          if (movie.id == null) continue;
          batch.insert(
            _database.popularMoviesTable,
            PopularMoviesTableCompanion(
              id: drift.Value(movie.id!),
              adult: drift.Value(movie.adult),
              backdropPath: drift.Value(movie.backdropPath),
              genreIds: drift.Value(_genreIdsToJson(movie.genreIds)),
              originalLanguage: drift.Value(movie.originalLanguage),
              originalTitle: drift.Value(movie.originalTitle),
              overview: drift.Value(movie.overview),
              popularity: drift.Value(movie.popularity),
              posterPath: drift.Value(movie.posterPath),
              releaseDate: drift.Value(movie.releaseDate?.toIso8601String()),
              title: drift.Value(movie.title),
              video: drift.Value(movie.video),
              voteAverage: drift.Value(movie.voteAverage),
              voteCount: drift.Value(movie.voteCount),
            ),
          );
        }
      });
    } catch (e) {
      debugPrint(' Error al cachear películas populares: $e');
    }
  }

  @override
  Future<List<PopularMovieDbModel>?> getCachedPopularMovies() async {
    try {
      final rows = await _database.select(_database.popularMoviesTable).get();
      if (rows.isEmpty) return null;

      return rows
          .map(
            (row) => PopularMovieDbModel(
              adult: row.adult,
              backdropPath: row.backdropPath,
              genreIds: _genreIdsFromJson(row.genreIds),
              id: row.id,
              originalLanguage: row.originalLanguage,
              originalTitle: row.originalTitle,
              overview: row.overview,
              popularity: row.popularity,
              posterPath: row.posterPath,
              releaseDate: row.releaseDate != null
                  ? DateParser.parseReleaseDate(row.releaseDate!)
                  : null,
              title: row.title,
              video: row.video,
              voteAverage: row.voteAverage,
              voteCount: row.voteCount,
            ),
          )
          .toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheNowPlayingMovies(List<PopularMovieDbModel> movies) async {
    try {
      await _database.delete(_database.nowPlayingMoviesTable).go();
      await _database.batch((batch) {
        for (final movie in movies) {
          if (movie.id == null) continue;
          batch.insert(
            _database.nowPlayingMoviesTable,
            NowPlayingMoviesTableCompanion(
              id: drift.Value(movie.id!),
              adult: drift.Value(movie.adult),
              backdropPath: drift.Value(movie.backdropPath),
              genreIds: drift.Value(_genreIdsToJson(movie.genreIds)),
              originalLanguage: drift.Value(movie.originalLanguage),
              originalTitle: drift.Value(movie.originalTitle),
              overview: drift.Value(movie.overview),
              popularity: drift.Value(movie.popularity),
              posterPath: drift.Value(movie.posterPath),
              releaseDate: drift.Value(movie.releaseDate?.toIso8601String()),
              title: drift.Value(movie.title),
              video: drift.Value(movie.video),
              voteAverage: drift.Value(movie.voteAverage),
              voteCount: drift.Value(movie.voteCount),
            ),
          );
        }
      });
    } catch (e) {
      debugPrint(' Error al cachear películas en cartelera: $e');
    }
  }

  @override
  Future<List<PopularMovieDbModel>?> getCachedNowPlayingMovies() async {
    try {
      final rows =
          await _database.select(_database.nowPlayingMoviesTable).get();
      if (rows.isEmpty) return null;

      return rows
          .map(
            (row) => PopularMovieDbModel(
              adult: row.adult,
              backdropPath: row.backdropPath,
              genreIds: _genreIdsFromJson(row.genreIds),
              id: row.id,
              originalLanguage: row.originalLanguage,
              originalTitle: row.originalTitle,
              overview: row.overview,
              popularity: row.popularity,
              posterPath: row.posterPath,
              releaseDate: row.releaseDate != null
                  ? DateParser.parseReleaseDate(row.releaseDate!)
                  : null,
              title: row.title,
              video: row.video,
              voteAverage: row.voteAverage,
              voteCount: row.voteCount,
            ),
          )
          .toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheTopRatedMovies(List<PopularMovieDbModel> movies) async {
    try {
      await _database.delete(_database.topRatedMoviesTable).go();
      await _database.batch((batch) {
        for (final movie in movies) {
          if (movie.id == null) continue;
          batch.insert(
            _database.topRatedMoviesTable,
            TopRatedMoviesTableCompanion(
              id: drift.Value(movie.id!),
              adult: drift.Value(movie.adult),
              backdropPath: drift.Value(movie.backdropPath),
              genreIds: drift.Value(_genreIdsToJson(movie.genreIds)),
              originalLanguage: drift.Value(movie.originalLanguage),
              originalTitle: drift.Value(movie.originalTitle),
              overview: drift.Value(movie.overview),
              popularity: drift.Value(movie.popularity),
              posterPath: drift.Value(movie.posterPath),
              releaseDate: drift.Value(movie.releaseDate?.toIso8601String()),
              title: drift.Value(movie.title),
              video: drift.Value(movie.video),
              voteAverage: drift.Value(movie.voteAverage),
              voteCount: drift.Value(movie.voteCount),
            ),
          );
        }
      });
    } catch (e) {
      debugPrint(' Error al cachear películas mejor calificadas: $e');
    }
  }

  @override
  Future<List<PopularMovieDbModel>?> getCachedTopRatedMovies() async {
    try {
      final rows = await _database.select(_database.topRatedMoviesTable).get();
      if (rows.isEmpty) return null;

      return rows
          .map(
            (row) => PopularMovieDbModel(
              adult: row.adult,
              backdropPath: row.backdropPath,
              genreIds: _genreIdsFromJson(row.genreIds),
              id: row.id,
              originalLanguage: row.originalLanguage,
              originalTitle: row.originalTitle,
              overview: row.overview,
              popularity: row.popularity,
              posterPath: row.posterPath,
              releaseDate: row.releaseDate != null
                  ? DateParser.parseReleaseDate(row.releaseDate!)
                  : null,
              title: row.title,
              video: row.video,
              voteAverage: row.voteAverage,
              voteCount: row.voteCount,
            ),
          )
          .toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheGenres(List<GenreDbModel> genres) async {
    try {
      await _database.delete(_database.genresTable).go();
      await _database.batch((batch) {
        for (final genre in genres) {
          if (genre.id == null) continue;
          batch.insert(
            _database.genresTable,
            GenresTableCompanion(
              id: drift.Value(genre.id!),
              name: drift.Value(genre.name),
            ),
          );
        }
      });
    } catch (e) {
      debugPrint(' Error al cachear géneros: $e');
    }
  }

  @override
  Future<List<GenreDbModel>?> getCachedGenres() async {
    try {
      final rows = await _database.select(_database.genresTable).get();
      if (rows.isEmpty) return null;

      return rows.map((row) => GenreDbModel(id: row.id, name: row.name)).toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheMoviesByGenre(
    int genreId,
    List<PopularMovieDbModel> movies,
  ) async {
    try {
      await (_database.delete(
        _database.moviesByGenreTable,
      )..where((tbl) => tbl.genreId.equals(genreId))).go();

      await _database.batch((batch) {
        for (final movie in movies) {
          if (movie.id == null) continue;
          batch.insert(
            _database.moviesByGenreTable,
            MoviesByGenreTableCompanion(
              genreId: drift.Value(genreId),
              movieId: drift.Value(movie.id!),
              adult: drift.Value(movie.adult),
              backdropPath: drift.Value(movie.backdropPath),
              genreIds: drift.Value(_genreIdsToJson(movie.genreIds)),
              originalLanguage: drift.Value(movie.originalLanguage),
              originalTitle: drift.Value(movie.originalTitle),
              overview: drift.Value(movie.overview),
              popularity: drift.Value(movie.popularity),
              posterPath: drift.Value(movie.posterPath),
              releaseDate: drift.Value(movie.releaseDate?.toIso8601String()),
              title: drift.Value(movie.title),
              video: drift.Value(movie.video),
              voteAverage: drift.Value(movie.voteAverage),
              voteCount: drift.Value(movie.voteCount),
            ),
          );
        }
      });
    } catch (e) {
      debugPrint(' Error al cachear películas por género: $e');
    }
  }

  @override
  Future<List<PopularMovieDbModel>?> getCachedMoviesByGenre(
      int genreId) async {
    try {
      final query = _database.select(_database.moviesByGenreTable)
        ..where((tbl) => tbl.genreId.equals(genreId));

      final rows = await query.get();
      if (rows.isEmpty) return null;

      return rows
          .map(
            (row) => PopularMovieDbModel(
              adult: row.adult,
              backdropPath: row.backdropPath,
              genreIds: _genreIdsFromJson(row.genreIds),
              id: row.movieId,
              originalLanguage: row.originalLanguage,
              originalTitle: row.originalTitle,
              overview: row.overview,
              popularity: row.popularity,
              posterPath: row.posterPath,
              releaseDate: row.releaseDate != null
                  ? DateParser.parseReleaseDate(row.releaseDate!)
                  : null,
              title: row.title,
              video: row.video,
              voteAverage: row.voteAverage,
              voteCount: row.voteCount,
            ),
          )
          .toList();
    } catch (e) {
      return null;
    }
  }
}
