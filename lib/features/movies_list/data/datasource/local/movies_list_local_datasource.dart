import 'package:imdumb/core/database/cache_database_service.dart';
import 'package:imdumb/features/home/data/models/popular_movie_db_model.dart';
import 'package:imdumb/features/movies_list/domain/entities/movie_list_type.dart';

/// SOLID: Single Responsibility Principle (SRP) y Dependency Inversion Principle (DIP)
///
/// Este datasource tiene una única responsabilidad: gestionar el almacenamiento
/// y recuperación de datos locales para listas de películas. No maneja lógica de negocio,
/// solo delega las operaciones de caché al servicio de base de datos.
///
/// Patrón aplicado: Repository Pattern (Data Source Layer) + Dependency Inversion
/// Separa la lógica de persistencia local de la lógica de negocio,
/// y depende de la abstracción CacheDatabaseService en lugar de una implementación concreta.
/// Esto permite cambiar entre Drift y SQLite sin modificar este código.
class MoviesListLocalDataSource {
  final CacheDatabaseService _cacheService;

  MoviesListLocalDataSource({required CacheDatabaseService cacheService})
    : _cacheService = cacheService;

  /// Obtiene películas de caché según el tipo
  Future<List<PopularMovieDbModel>?> getCachedMovies({
    required MovieListType type,
    int? genreId,
  }) async {
    switch (type) {
      case MovieListType.popular:
        return await _cacheService.getCachedPopularMovies();
      case MovieListType.nowPlaying:
        return await _cacheService.getCachedNowPlayingMovies();
      case MovieListType.topRated:
        return await _cacheService.getCachedTopRatedMovies();
      case MovieListType.genre:
        if (genreId != null) {
          return await _cacheService.getCachedMoviesByGenre(genreId);
        }
        return null;
    }
  }

  /// Guarda películas en caché según el tipo
  Future<void> cacheMovies({
    required MovieListType type,
    required List<PopularMovieDbModel> movies,
    int? genreId,
  }) async {
    switch (type) {
      case MovieListType.popular:
        await _cacheService.cachePopularMovies(movies);
        break;
      case MovieListType.nowPlaying:
        await _cacheService.cacheNowPlayingMovies(movies);
        break;
      case MovieListType.topRated:
        await _cacheService.cacheTopRatedMovies(movies);
        break;
      case MovieListType.genre:
        if (genreId != null) {
          await _cacheService.cacheMoviesByGenre(genreId, movies);
        }
        break;
    }
  }
}
