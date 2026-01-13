import 'package:dartz/dartz.dart';
import 'package:imdumb/core/utils/constans/app_language.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/data/datasource/home_datasource.dart';
import 'package:imdumb/features/home/data/datasource/local/home_local_datasource.dart';
import 'package:imdumb/features/home/data/mappers/popular_movie_mapper.dart';
import 'package:imdumb/features/home/data/mappers/genre_mapper.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/home/domain/entities/genre_entity.dart';
import 'package:imdumb/features/home/domain/repository/home_repository.dart';

/// SOLID: Single Responsibility Principle (SRP) & Dependency Inversion Principle (DIP)
///
/// Este repositorio tiene una única responsabilidad: coordinar entre
/// las fuentes de datos locales (Drift) y remotas (API), implementando
/// una estrategia de caché (Cache-First).
///
/// Patrón aplicado: Repository Pattern & Strategy Pattern (Cache-First)
/// - Primero intenta obtener datos de la caché local
/// - Si no hay datos en caché, obtiene de la API remota
/// - Guarda los datos remotos en caché para futuras consultas
class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource _remoteDatasource;
  final HomeLocalDataSource _localDatasource;

  HomeRepositoryImpl({
    required HomeDatasource remoteDatasource,
    required HomeLocalDataSource localDatasource,
  })  : _remoteDatasource = remoteDatasource,
        _localDatasource = localDatasource;
  @override
  Future<Either<AppException, List<PopularMovieEntity>>> fetchAllPopularMovies({
    String page = "1",
    String? language = AppLanguage.spanish,
  }) async {
    // Cache-First Strategy: Primero intenta obtener de caché local
    if (page == "1") {
      final cachedMovies = await _localDatasource.getCachedPopularMovies();
      if (cachedMovies != null && cachedMovies.isNotEmpty) {
        return Right(cachedMovies.toEntityList());
      }
    }

    // Si no hay caché, obtiene de la API remota
    final response = await _remoteDatasource.fetchAllPopularMovies(
      page: page,
      language: language,
    );

    return response.fold(
      (failure) => Left(failure),
      (movies) async {
        // Guarda en caché solo la primera página
        if (page == "1") {
          await _localDatasource.cachePopularMovies(movies);
        }
        return Right(movies.toEntityList());
      },
    );
  }

  @override
  Future<Either<AppException, List<PopularMovieEntity>>> fetchAllNowPlayingMovies({
    String page = "1",
    String? language = AppLanguage.spanish,
  }) async {
    // Cache-First Strategy: Primero intenta obtener de caché local
    if (page == "1") {
      final cachedMovies = await _localDatasource.getCachedNowPlayingMovies();
      if (cachedMovies != null && cachedMovies.isNotEmpty) {
        return Right(cachedMovies.toEntityList());
      }
    }

    // Si no hay caché, obtiene de la API remota
    final response = await _remoteDatasource.fetchAllNowPlayingMovies(
      page: page,
      language: language,
    );

    return response.fold(
      (failure) => Left(failure),
      (movies) async {
        // Guarda en caché solo la primera página
        if (page == "1") {
          await _localDatasource.cacheNowPlayingMovies(movies);
        }
        return Right(movies.toEntityList());
      },
    );
  }

  @override
  Future<Either<AppException, List<PopularMovieEntity>>> fetchAllTopRatedMovies({
    String page = "1",
    String? language = AppLanguage.spanish,
  }) async {
    // Cache-First Strategy: Primero intenta obtener de caché local
    if (page == "1") {
      final cachedMovies = await _localDatasource.getCachedTopRatedMovies();
      if (cachedMovies != null && cachedMovies.isNotEmpty) {
        return Right(cachedMovies.toEntityList());
      }
    }

    // Si no hay caché, obtiene de la API remota
    final response = await _remoteDatasource.fetchAllTopRatedMovies(
      page: page,
      language: language,
    );

    return response.fold(
      (failure) => Left(failure),
      (movies) async {
        // Guarda en caché solo la primera página
        if (page == "1") {
          await _localDatasource.cacheTopRatedMovies(movies);
        }
        return Right(movies.toEntityList());
      },
    );
  }

  @override
  Future<Either<AppException, List<GenreEntity>>> fetchAllGenres({
    String? language = AppLanguage.spanish,
  }) async {
    // Cache-First Strategy: Primero intenta obtener de caché local
    final cachedGenres = await _localDatasource.getCachedGenres();
    if (cachedGenres != null && cachedGenres.isNotEmpty) {
      return Right(cachedGenres.toEntityList());
    }

    // Si no hay caché, obtiene de la API remota
    final response = await _remoteDatasource.fetchAllGenres(language: language);

    return response.fold(
      (failure) => Left(failure),
      (genres) async {
        // Guarda en caché
        await _localDatasource.cacheGenres(genres);
        return Right(genres.toEntityList());
      },
    );
  }

  @override
  Future<Either<AppException, List<PopularMovieEntity>>> fetchMoviesByGenre({
    required int genreId,
    String page = "1",
    String? language = AppLanguage.spanish,
  }) async {
    // Cache-First Strategy: Primero intenta obtener de caché local (solo primera página)
    if (page == "1") {
      final cachedMovies =
          await _localDatasource.getCachedMoviesByGenre(genreId);
      if (cachedMovies != null && cachedMovies.isNotEmpty) {
        return Right(cachedMovies.toEntityList());
      }
    }

    // Si no hay caché, obtiene de la API remota
    final response = await _remoteDatasource.fetchMoviesByGenre(
      genreId: genreId,
      page: page,
      language: language,
    );

    return response.fold(
      (failure) => Left(failure),
      (movies) async {
        // Guarda en caché solo la primera página
        if (page == "1") {
          await _localDatasource.cacheMoviesByGenre(genreId, movies);
        }
        return Right(movies.toEntityList());
      },
    );
  }
}
