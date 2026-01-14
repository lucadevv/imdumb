import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:imdumb/core/database/cache_database_service.dart';
import 'package:imdumb/core/utils/helpers/date_parser.dart';
import 'package:imdumb/features/home/data/models/popular_movie_db_model.dart';
import 'package:imdumb/features/home/data/models/genre_db_model.dart';
import 'package:imdumb/features/movie_detail/data/models/movie_detail_db_model.dart';
import 'package:imdumb/features/movie_detail/data/models/movie_image_db_model.dart';
import 'package:imdumb/features/movie_detail/data/models/cast_db_model.dart';

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
  static const int _databaseVersion = 2;

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

    // Tabla de detalles de películas
    await db.execute('''
      CREATE TABLE movie_details (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        vote_average REAL,
        vote_count INTEGER,
        release_date TEXT,
        backdrop_path TEXT,
        poster_path TEXT,
        runtime INTEGER,
        genres TEXT
      )
    ''');

    // Tabla de imágenes de películas
    await db.execute('''
      CREATE TABLE movie_images (
        movie_id INTEGER,
        file_path TEXT,
        PRIMARY KEY (movie_id, file_path)
      )
    ''');

    // Tabla de créditos (cast) de películas
    await db.execute('''
      CREATE TABLE movie_credits (
        movie_id INTEGER,
        cast_id INTEGER,
        name TEXT,
        character TEXT,
        profile_path TEXT,
        PRIMARY KEY (movie_id, cast_id)
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Agregar tablas para movie details, images y credits
      await db.execute('''
        CREATE TABLE IF NOT EXISTS movie_details (
          id INTEGER PRIMARY KEY,
          title TEXT,
          overview TEXT,
          vote_average REAL,
          vote_count INTEGER,
          release_date TEXT,
          backdrop_path TEXT,
          poster_path TEXT,
          runtime INTEGER,
          genres TEXT
        )
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS movie_images (
          movie_id INTEGER,
          file_path TEXT,
          PRIMARY KEY (movie_id, file_path)
        )
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS movie_credits (
          movie_id INTEGER,
          cast_id INTEGER,
          name TEXT,
          character TEXT,
          profile_path TEXT,
          PRIMARY KEY (movie_id, cast_id)
        )
      ''');
    }
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

  @override
  Future<void> cacheMovieDetail(int movieId, MovieDetailDbModel movieDetail) async {
    try {
      final db = await database;
      await db.transaction((txn) async {
        await txn.delete('movie_details', where: 'id = ?', whereArgs: [movieId]);
        await txn.insert('movie_details', {
          'id': movieDetail.id ?? movieId,
          'title': movieDetail.title,
          'overview': movieDetail.overview,
          'vote_average': movieDetail.voteAverage,
          'vote_count': movieDetail.voteCount,
          'release_date': movieDetail.releaseDate,
          'backdrop_path': movieDetail.backdropPath,
          'poster_path': movieDetail.posterPath,
          'runtime': movieDetail.runtime,
          'genres': movieDetail.genres != null ? jsonEncode(movieDetail.genres) : null,
        });
      });
    } catch (e) {
      debugPrint('Error al cachear detalle de película: $e');
    }
  }

  @override
  Future<MovieDetailDbModel?> getCachedMovieDetail(int movieId) async {
    try {
      final db = await database;
      final maps = await db.query(
        'movie_details',
        where: 'id = ?',
        whereArgs: [movieId],
      );
      if (maps.isEmpty) return null;
      final map = maps.first;
      return MovieDetailDbModel(
        id: map['id'] as int?,
        title: map['title'] as String?,
        overview: map['overview'] as String?,
        voteAverage: map['vote_average'] as double?,
        voteCount: map['vote_count'] as int?,
        releaseDate: map['release_date'] as String?,
        backdropPath: map['backdrop_path'] as String?,
        posterPath: map['poster_path'] as String?,
        runtime: map['runtime'] as int?,
        genres: map['genres'] != null
            ? (jsonDecode(map['genres'] as String) as List)
                .map((e) => e as Map<String, dynamic>)
                .toList()
            : null,
      );
    } catch (e) {
      debugPrint('Error al obtener detalle de película: $e');
      return null;
    }
  }

  @override
  Future<void> cacheMovieImages(int movieId, List<MovieImageDbModel> images) async {
    try {
      final db = await database;
      await db.transaction((txn) async {
        await txn.delete('movie_images', where: 'movie_id = ?', whereArgs: [movieId]);
        final batch = txn.batch();
        for (final image in images) {
          if (image.filePath == null || image.filePath!.isEmpty) continue;
          batch.insert('movie_images', {
            'movie_id': movieId,
            'file_path': image.filePath,
          });
        }
        await batch.commit(noResult: true);
      });
    } catch (e) {
      debugPrint('Error al cachear imágenes de película: $e');
    }
  }

  @override
  Future<List<MovieImageDbModel>?> getCachedMovieImages(int movieId) async {
    try {
      final db = await database;
      final maps = await db.query(
        'movie_images',
        where: 'movie_id = ?',
        whereArgs: [movieId],
      );
      if (maps.isEmpty) return null;
      return maps
          .map((map) => MovieImageDbModel(
                filePath: map['file_path'] as String?,
              ))
          .toList();
    } catch (e) {
      debugPrint('Error al obtener imágenes de película: $e');
      return null;
    }
  }

  @override
  Future<void> cacheMovieCredits(int movieId, List<CastDbModel> casts) async {
    try {
      final db = await database;
      await db.transaction((txn) async {
        await txn.delete('movie_credits', where: 'movie_id = ?', whereArgs: [movieId]);
        final batch = txn.batch();
        for (final cast in casts) {
          if (cast.id == null) continue;
          batch.insert('movie_credits', {
            'movie_id': movieId,
            'cast_id': cast.id,
            'name': cast.name,
            'character': cast.character,
            'profile_path': cast.profilePath,
          });
        }
        await batch.commit(noResult: true);
      });
    } catch (e) {
      debugPrint('Error al cachear créditos de película: $e');
    }
  }

  @override
  Future<List<CastDbModel>?> getCachedMovieCredits(int movieId) async {
    try {
      final db = await database;
      final maps = await db.query(
        'movie_credits',
        where: 'movie_id = ?',
        whereArgs: [movieId],
      );
      if (maps.isEmpty) return null;
      return maps
          .map((map) => CastDbModel(
                id: map['cast_id'] as int?,
                name: map['name'] as String?,
                character: map['character'] as String?,
                profilePath: map['profile_path'] as String?,
              ))
          .toList();
    } catch (e) {
      debugPrint('Error al obtener créditos de película: $e');
      return null;
    }
  }
}
