import 'package:dartz/dartz.dart';
import 'package:imdumb/core/utils/constans/app_language.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/data/mappers/popular_movie_mapper.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/movies_list/data/datasource/movies_list_datasource.dart';
import 'package:imdumb/features/movies_list/data/datasource/local/movies_list_local_datasource.dart';
import 'package:imdumb/features/movies_list/domain/entities/movie_list_type.dart';
import 'package:imdumb/features/movies_list/domain/repository/movies_list_repository.dart';

/// SOLID: Single Responsibility Principle (SRP) & Dependency Inversion Principle (DIP)
///
/// Este repositorio tiene una única responsabilidad: coordinar entre
/// las fuentes de datos locales (caché) y remotas (API), implementando
/// una estrategia de caché (Cache-First).
///
/// Patrón aplicado: Repository Pattern & Strategy Pattern (Cache-First)
/// - Primero intenta obtener datos de la caché local (solo para página 1)
/// - Si no hay datos en caché, obtiene de la API remota
/// - Guarda los datos remotos en caché para futuras consultas
class MoviesListRepositoryImpl implements MoviesListRepository {
  final MoviesListDatasource _remoteDatasource;
  final MoviesListLocalDataSource _localDatasource;

  MoviesListRepositoryImpl({
    required MoviesListDatasource remoteDatasource,
    required MoviesListLocalDataSource localDatasource,
  })  : _remoteDatasource = remoteDatasource,
        _localDatasource = localDatasource;

  @override
  Future<Either<AppException, List<PopularMovieEntity>>> fetchMovies({
    required MovieListType type,
    int? genreId,
    String page = "1",
    String? language = AppLanguage.spanish,
  }) async {
    // Cache-First Strategy: Primero intenta obtener de caché local (solo página 1)
    if (page == "1") {
      final cachedMovies = await _localDatasource.getCachedMovies(
        type: type,
        genreId: genreId,
      );
      if (cachedMovies != null && cachedMovies.isNotEmpty) {
        return Right(cachedMovies.toEntityList());
      }
    }

    // Si no hay caché, obtiene de la API remota
    final response = await _remoteDatasource.fetchMovies(
      type: type,
      genreId: genreId,
      page: page,
      language: language,
    );

    return response.fold(
      (failure) => Left(failure),
      (movies) async {
        // Guarda en caché solo la primera página
        if (page == "1") {
          await _localDatasource.cacheMovies(
            type: type,
            movies: movies,
            genreId: genreId,
          );
        }
        return Right(movies.toEntityList());
      },
    );
  }
}
