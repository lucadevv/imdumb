import 'package:imdumb/features/home/data/models/genre_db_model.dart';
import 'package:imdumb/features/home/data/models/popular_movie_db_model.dart';
import 'package:imdumb/features/movie_detail/data/models/movie_detail_db_model.dart';
import 'package:imdumb/features/movie_detail/data/models/movie_image_db_model.dart';
import 'package:imdumb/features/movie_detail/data/models/cast_db_model.dart';

/// SOLID: Dependency Inversion Principle (DIP) y Open/Closed Principle (OCP)
///
/// Esta interfaz abstracta define el contrato para servicios de caché de base de datos.
/// Las clases de alto nivel (datasources, repositorios) dependen de esta abstracción,
/// no de implementaciones concretas (Drift, SQLite, etc.).
///
/// Esto permite cambiar la implementación de base de datos sin afectar el código cliente,
/// siguiendo los principios SOLID de Inversión de Dependencias y Abierto/Cerrado.
///
/// Patrón aplicado: Strategy Pattern + Dependency Inversion
/// Permite intercambiar diferentes estrategias de almacenamiento (Drift, SQLite, etc.)
/// sin modificar el código que las utiliza.
abstract class CacheDatabaseService {
  /// Guarda películas populares en caché
  Future<void> cachePopularMovies(List<PopularMovieDbModel> movies);

  /// Obtiene películas populares de caché
  Future<List<PopularMovieDbModel>?> getCachedPopularMovies();

  /// Guarda películas en cartelera en caché
  Future<void> cacheNowPlayingMovies(List<PopularMovieDbModel> movies);

  /// Obtiene películas en cartelera de caché
  Future<List<PopularMovieDbModel>?> getCachedNowPlayingMovies();

  /// Guarda películas mejor calificadas en caché
  Future<void> cacheTopRatedMovies(List<PopularMovieDbModel> movies);

  /// Obtiene películas mejor calificadas de caché
  Future<List<PopularMovieDbModel>?> getCachedTopRatedMovies();

  /// Guarda géneros en caché
  Future<void> cacheGenres(List<GenreDbModel> genres);

  /// Obtiene géneros de caché
  Future<List<GenreDbModel>?> getCachedGenres();

  /// Guarda películas por género en caché
  Future<void> cacheMoviesByGenre(
    int genreId,
    List<PopularMovieDbModel> movies,
  );

  /// Obtiene películas por género de caché
  Future<List<PopularMovieDbModel>?> getCachedMoviesByGenre(int genreId);

  /// Guarda detalle de película en caché
  Future<void> cacheMovieDetail(int movieId, MovieDetailDbModel movieDetail);

  /// Obtiene detalle de película de caché
  Future<MovieDetailDbModel?> getCachedMovieDetail(int movieId);

  /// Guarda imágenes de película en caché
  Future<void> cacheMovieImages(int movieId, List<MovieImageDbModel> images);

  /// Obtiene imágenes de película de caché
  Future<List<MovieImageDbModel>?> getCachedMovieImages(int movieId);

  /// Guarda créditos (cast) de película en caché
  Future<void> cacheMovieCredits(int movieId, List<CastDbModel> casts);

  /// Obtiene créditos (cast) de película de caché
  Future<List<CastDbModel>?> getCachedMovieCredits(int movieId);
}
