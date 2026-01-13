import 'package:imdumb/core/database/cache_database_service.dart';
import 'package:imdumb/features/home/data/models/popular_movie_db_model.dart';
import 'package:imdumb/features/home/data/models/genre_db_model.dart';

/// SOLID: Single Responsibility Principle (SRP) y Dependency Inversion Principle (DIP)
///
/// Este datasource tiene una única responsabilidad: gestionar el almacenamiento
/// y recuperación de datos locales. No maneja lógica de negocio,
/// solo delega las operaciones de caché al servicio de base de datos.
///
/// Patrón aplicado: Repository Pattern (Data Source Layer) + Dependency Inversion
/// Separa la lógica de persistencia local de la lógica de negocio,
/// y depende de la abstracción CacheDatabaseService en lugar de una implementación concreta.
/// Esto permite cambiar entre Drift y SQLite sin modificar este código.
class HomeLocalDataSource {
  final CacheDatabaseService _cacheService;

  HomeLocalDataSource({required CacheDatabaseService cacheService})
      : _cacheService = cacheService;

  /// Guarda películas populares en caché
  Future<void> cachePopularMovies(List<PopularMovieDbModel> movies) async {
    await _cacheService.cachePopularMovies(movies);
  }

  /// Obtiene películas populares de caché
  Future<List<PopularMovieDbModel>?> getCachedPopularMovies() async {
    return await _cacheService.getCachedPopularMovies();
  }

  /// Guarda películas en cartelera en caché
  Future<void> cacheNowPlayingMovies(List<PopularMovieDbModel> movies) async {
    await _cacheService.cacheNowPlayingMovies(movies);
  }

  /// Obtiene películas en cartelera de caché
  Future<List<PopularMovieDbModel>?> getCachedNowPlayingMovies() async {
    return await _cacheService.getCachedNowPlayingMovies();
  }

  /// Guarda películas mejor calificadas en caché
  Future<void> cacheTopRatedMovies(List<PopularMovieDbModel> movies) async {
    await _cacheService.cacheTopRatedMovies(movies);
  }

  /// Obtiene películas mejor calificadas de caché
  Future<List<PopularMovieDbModel>?> getCachedTopRatedMovies() async {
    return await _cacheService.getCachedTopRatedMovies();
  }

  /// Guarda géneros en caché
  Future<void> cacheGenres(List<GenreDbModel> genres) async {
    await _cacheService.cacheGenres(genres);
  }

  /// Obtiene géneros de caché
  Future<List<GenreDbModel>?> getCachedGenres() async {
    return await _cacheService.getCachedGenres();
  }

  /// Guarda películas por género en caché
  Future<void> cacheMoviesByGenre(
    int genreId,
    List<PopularMovieDbModel> movies,
  ) async {
    await _cacheService.cacheMoviesByGenre(genreId, movies);
  }

  /// Obtiene películas por género de caché
  Future<List<PopularMovieDbModel>?> getCachedMoviesByGenre(int genreId) async {
    return await _cacheService.getCachedMoviesByGenre(genreId);
  }
}
