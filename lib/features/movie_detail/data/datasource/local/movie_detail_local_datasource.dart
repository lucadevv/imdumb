import 'package:imdumb/core/database/cache_database_service.dart';
import 'package:imdumb/features/movie_detail/data/models/movie_detail_db_model.dart';
import 'package:imdumb/features/movie_detail/data/models/movie_image_db_model.dart';
import 'package:imdumb/features/movie_detail/data/models/cast_db_model.dart';

/// SOLID: Single Responsibility Principle (SRP) y Dependency Inversion Principle (DIP)
///
/// Este datasource tiene una única responsabilidad: gestionar el almacenamiento
/// y recuperación de datos locales para detalles de películas. No maneja lógica de negocio,
/// solo delega las operaciones de caché al servicio de base de datos.
///
/// Patrón aplicado: Repository Pattern (Data Source Layer) + Dependency Inversion
/// Separa la lógica de persistencia local de la lógica de negocio,
/// y depende de la abstracción CacheDatabaseService en lugar de una implementación concreta.
/// Esto permite cambiar entre Drift y SQLite sin modificar este código.
class MovieDetailLocalDataSource {
  final CacheDatabaseService _cacheService;

  MovieDetailLocalDataSource({required CacheDatabaseService cacheService})
      : _cacheService = cacheService;

  /// Obtiene detalle de película de caché
  Future<MovieDetailDbModel?> getCachedMovieDetail(int movieId) async {
    return await _cacheService.getCachedMovieDetail(movieId);
  }

  /// Guarda detalle de película en caché
  Future<void> cacheMovieDetail(int movieId, MovieDetailDbModel movieDetail) async {
    await _cacheService.cacheMovieDetail(movieId, movieDetail);
  }

  /// Obtiene imágenes de película de caché
  Future<List<MovieImageDbModel>?> getCachedMovieImages(int movieId) async {
    return await _cacheService.getCachedMovieImages(movieId);
  }

  /// Guarda imágenes de película en caché
  Future<void> cacheMovieImages(int movieId, List<MovieImageDbModel> images) async {
    await _cacheService.cacheMovieImages(movieId, images);
  }

  /// Obtiene créditos (cast) de película de caché
  Future<List<CastDbModel>?> getCachedMovieCredits(int movieId) async {
    return await _cacheService.getCachedMovieCredits(movieId);
  }

  /// Guarda créditos (cast) de película en caché
  Future<void> cacheMovieCredits(int movieId, List<CastDbModel> casts) async {
    await _cacheService.cacheMovieCredits(movieId, casts);
  }
}