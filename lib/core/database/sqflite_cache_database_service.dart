import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:imdumb/core/database/cache_database_service.dart';
import 'package:imdumb/core/utils/helpers/date_parser.dart';
import 'package:imdumb/features/home/data/models/popular_movie_db_model.dart';
import 'package:imdumb/features/home/data/models/genre_db_model.dart';

/// SOLID: Open/Closed Principle (OCP)
///
/// Esta implementación está abierta para extensión pero cerrada para modificación.
/// Implementa CacheDatabaseService usando SQLite a través de sqflite.
/// Puede ser reemplazada por otra implementación sin modificar el código cliente.
///
/// Patrón aplicado: Strategy Pattern
/// Proporciona una estrategia alternativa de almacenamiento usando SQLite nativo.
class SqfliteCacheDatabaseService implements CacheDatabaseService {
  static const String _databaseName = 'app_cache.db';
  static const int _databaseVersion = 1;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Tabla de películas populares
    await db.execute('''
      CREATE TABLE popular_movies (
        id INTEGER PRIMARY KEY,
        adult INTEGER,
        backdrop_path TEXT,
        genre_ids TEXT,
        original_language TEXT,
        original_title TEXT,
        overview TEXT,
        popularity REAL,
        poster_path TEXT,
        release_date TEXT,
        title TEXT,
        video INTEGER,
        vote_average REAL,
        vote_count INTEGER
      )
    ''');

    // Tabla de películas en cartelera
    await db.execute('''
      CREATE TABLE now_playing_movies (
        id INTEGER PRIMARY KEY,
        adult INTEGER,
        backdrop_path TEXT,
        genre_ids TEXT,
        original_language TEXT,
        original_title TEXT,
        overview TEXT,
        popularity REAL,
        poster_path TEXT,
        release_date TEXT,
        title TEXT,
        video INTEGER,
        vote_average REAL,
        vote_count INTEGER
      )
    ''');

    // Tabla de películas mejor calificadas
    await db.execute('''
      CREATE TABLE top_rated_movies (
        id INTEGER PRIMARY KEY,
        adult INTEGER,
        backdrop_path TEXT,
        genre_ids TEXT,
        original_language TEXT,
        original_title TEXT,
        overview TEXT,
        popularity REAL,
        poster_path TEXT,
        release_date TEXT,
        title TEXT,
        video INTEGER,
        vote_average REAL,
        vote_count INTEGER
      )
    ''');

    // Tabla de géneros
    await db.execute('''
      CREATE TABLE genres (
        id INTEGER PRIMARY KEY,
        name TEXT
      )
    ''');

    // Tabla de películas por género
    await db.execute('''
      CREATE TABLE movies_by_genre (
        genre_id INTEGER,
        movie_id INTEGER,
        adult INTEGER,
        backdrop_path TEXT,
        genre_ids TEXT,
        original_language TEXT,
        original_title TEXT,
        overview TEXT,
        popularity REAL,
        poster_path TEXT,
        release_date TEXT,
        title TEXT,
        video INTEGER,
        vote_average REAL,
        vote_count INTEGER,
        PRIMARY KEY (genre_id, movie_id)
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Implementar migraciones si es necesario en el futuro
  }

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

  Map<String, dynamic> _movieToMap(PopularMovieDbModel movie) {
    return {
      'id': movie.id,
      'adult': movie.adult == true ? 1 : 0,
      'backdrop_path': movie.backdropPath,
      'genre_ids': _genreIdsToJson(movie.genreIds),
      'original_language': movie.originalLanguage,
      'original_title': movie.originalTitle,
      'overview': movie.overview,
      'popularity': movie.popularity,
      'poster_path': movie.posterPath,
      'release_date': movie.releaseDate?.toIso8601String(),
      'title': movie.title,
      'video': movie.video == true ? 1 : 0,
      'vote_average': movie.voteAverage,
      'vote_count': movie.voteCount,
    };
  }

  PopularMovieDbModel _mapToMovie(Map<String, dynamic> map) {
    return PopularMovieDbModel(
      id: map['id'] as int?,
      adult: map['adult'] == 1,
      backdropPath: map['backdrop_path'] as String?,
      genreIds: _genreIdsFromJson(map['genre_ids'] as String?),
      originalLanguage: map['original_language'] as String?,
      originalTitle: map['original_title'] as String?,
      overview: map['overview'] as String?,
      popularity: map['popularity'] as double?,
      posterPath: map['poster_path'] as String?,
      releaseDate: map['release_date'] != null
          ? DateParser.parseReleaseDate(map['release_date'] as String)
          : null,
      title: map['title'] as String?,
      video: map['video'] == 1,
      voteAverage: map['vote_average'] as double?,
      voteCount: map['vote_count'] as int?,
    );
  }

  @override
  Future<void> cachePopularMovies(List<PopularMovieDbModel> movies) async {
    try {
      final db = await database;
      await db.transaction((txn) async {
        await txn.delete('popular_movies');
        final batch = txn.batch();
        for (final movie in movies) {
          if (movie.id == null) continue;
          batch.insert('popular_movies', _movieToMap(movie));
        }
        await batch.commit(noResult: true);
      });
    } catch (e) {
      debugPrint('Error al cachear películas populares: $e');
    }
  }

  @override
  Future<List<PopularMovieDbModel>?> getCachedPopularMovies() async {
    try {
      final db = await database;
      final maps = await db.query('popular_movies');
      if (maps.isEmpty) return null;
      return maps.map((map) => _mapToMovie(map)).toList();
    } catch (e) {
      debugPrint('Error al obtener películas populares: $e');
      return null;
    }
  }

  @override
  Future<void> cacheNowPlayingMovies(List<PopularMovieDbModel> movies) async {
    try {
      final db = await database;
      await db.transaction((txn) async {
        await txn.delete('now_playing_movies');
        final batch = txn.batch();
        for (final movie in movies) {
          if (movie.id == null) continue;
          batch.insert('now_playing_movies', _movieToMap(movie));
        }
        await batch.commit(noResult: true);
      });
    } catch (e) {
      debugPrint('Error al cachear películas en cartelera: $e');
    }
  }

  @override
  Future<List<PopularMovieDbModel>?> getCachedNowPlayingMovies() async {
    try {
      final db = await database;
      final maps = await db.query('now_playing_movies');
      if (maps.isEmpty) return null;
      return maps.map((map) => _mapToMovie(map)).toList();
    } catch (e) {
      debugPrint('Error al obtener películas en cartelera: $e');
      return null;
    }
  }

  @override
  Future<void> cacheTopRatedMovies(List<PopularMovieDbModel> movies) async {
    try {
      final db = await database;
      await db.transaction((txn) async {
        await txn.delete('top_rated_movies');
        final batch = txn.batch();
        for (final movie in movies) {
          if (movie.id == null) continue;
          batch.insert('top_rated_movies', _movieToMap(movie));
        }
        await batch.commit(noResult: true);
      });
    } catch (e) {
      debugPrint('Error al cachear películas mejor calificadas: $e');
    }
  }

  @override
  Future<List<PopularMovieDbModel>?> getCachedTopRatedMovies() async {
    try {
      final db = await database;
      final maps = await db.query('top_rated_movies');
      if (maps.isEmpty) return null;
      return maps.map((map) => _mapToMovie(map)).toList();
    } catch (e) {
      debugPrint('Error al obtener películas mejor calificadas: $e');
      return null;
    }
  }

  @override
  Future<void> cacheGenres(List<GenreDbModel> genres) async {
    try {
      final db = await database;
      await db.transaction((txn) async {
        await txn.delete('genres');
        final batch = txn.batch();
        for (final genre in genres) {
          if (genre.id == null) continue;
          batch.insert('genres', {
            'id': genre.id,
            'name': genre.name,
          });
        }
        await batch.commit(noResult: true);
      });
    } catch (e) {
      debugPrint('Error al cachear géneros: $e');
    }
  }

  @override
  Future<List<GenreDbModel>?> getCachedGenres() async {
    try {
      final db = await database;
      final maps = await db.query('genres');
      if (maps.isEmpty) return null;
      return maps
          .map((map) => GenreDbModel(
                id: map['id'] as int?,
                name: map['name'] as String?,
              ))
          .toList();
    } catch (e) {
      debugPrint('Error al obtener géneros: $e');
      return null;
    }
  }

  @override
  Future<void> cacheMoviesByGenre(
    int genreId,
    List<PopularMovieDbModel> movies,
  ) async {
    try {
      final db = await database;
      await db.transaction((txn) async {
        await txn.delete(
          'movies_by_genre',
          where: 'genre_id = ?',
          whereArgs: [genreId],
        );
        final batch = txn.batch();
        for (final movie in movies) {
          if (movie.id == null) continue;
          // Crear mapa sin 'id' ya que movies_by_genre no tiene esa columna
          final map = <String, dynamic>{
            'genre_id': genreId,
            'movie_id': movie.id,
            'adult': movie.adult == true ? 1 : 0,
            'backdrop_path': movie.backdropPath,
            'genre_ids': _genreIdsToJson(movie.genreIds),
            'original_language': movie.originalLanguage,
            'original_title': movie.originalTitle,
            'overview': movie.overview,
            'popularity': movie.popularity,
            'poster_path': movie.posterPath,
            'release_date': movie.releaseDate?.toIso8601String(),
            'title': movie.title,
            'video': movie.video == true ? 1 : 0,
            'vote_average': movie.voteAverage,
            'vote_count': movie.voteCount,
          };
          batch.insert('movies_by_genre', map);
        }
        await batch.commit(noResult: true);
      });
    } catch (e) {
      debugPrint('Error al cachear películas por género: $e');
    }
  }

  @override
  Future<List<PopularMovieDbModel>?> getCachedMoviesByGenre(int genreId) async {
    try {
      final db = await database;
      final maps = await db.query(
        'movies_by_genre',
        where: 'genre_id = ?',
        whereArgs: [genreId],
      );
      if (maps.isEmpty) return null;
      return maps.map((map) {
        final movieMap = Map<String, dynamic>.from(map);
        movieMap['id'] = movieMap['movie_id'];
        return _mapToMovie(movieMap);
      }).toList();
    } catch (e) {
      debugPrint('Error al obtener películas por género: $e');
      return null;
    }
  }
}
