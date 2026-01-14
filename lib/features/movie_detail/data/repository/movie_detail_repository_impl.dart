import 'package:dartz/dartz.dart';
import 'package:imdumb/core/utils/constans/app_language.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/movie_detail/data/datasource/movie_detail_datasource.dart';
import 'package:imdumb/features/movie_detail/data/datasource/local/movie_detail_local_datasource.dart';
import 'package:imdumb/features/movie_detail/data/mappers/cast_mapper.dart';
import 'package:imdumb/features/movie_detail/data/mappers/credit_detail_mapper.dart';
import 'package:imdumb/features/movie_detail/data/mappers/movie_detail_mapper.dart';
import 'package:imdumb/features/movie_detail/data/mappers/movie_image_mapper.dart';
import 'package:imdumb/features/movie_detail/domain/entities/cast_entity.dart';
import 'package:imdumb/features/movie_detail/domain/entities/credit_detail_entity.dart';
import 'package:imdumb/features/movie_detail/domain/entities/movie_detail_entity.dart';
import 'package:imdumb/features/movie_detail/domain/entities/movie_image_entity.dart';
import 'package:imdumb/features/movie_detail/domain/repository/movie_detail_repository.dart';

/// SOLID: Single Responsibility Principle (SRP) & Dependency Inversion Principle (DIP)
///
/// Este repositorio tiene una única responsabilidad: coordinar entre
/// las fuentes de datos locales (caché) y remotas (API), implementando
/// una estrategia de caché (Cache-First).
///
/// Patrón aplicado: Repository Pattern & Strategy Pattern (Cache-First)
/// - Primero intenta obtener datos de la caché local
/// - Si no hay datos en caché, obtiene de la API remota
/// - Guarda los datos remotos en caché para futuras consultas
class MovieDetailRepositoryImpl implements MovieDetailRepository {
  final MovieDetailDatasource _remoteDatasource;
  final MovieDetailLocalDataSource _localDatasource;

  MovieDetailRepositoryImpl({
    required MovieDetailDatasource remoteDatasource,
    required MovieDetailLocalDataSource localDatasource,
  })  : _remoteDatasource = remoteDatasource,
        _localDatasource = localDatasource;

  @override
  Future<Either<AppException, MovieDetailEntity>> fetchMovieDetail({
    required int movieId,
    String? language = AppLanguage.spanish,
  }) async {
    // Cache-First Strategy: Primero intenta obtener de caché local
    final cachedDetail = await _localDatasource.getCachedMovieDetail(movieId);
    if (cachedDetail != null) {
      return Right(MovieDetailMapper.toEntity(cachedDetail));
    }

    // Si no hay caché, obtiene de la API remota
    final response = await _remoteDatasource.fetchMovieDetail(
      movieId: movieId,
      language: language,
    );

    return response.fold(
      (failure) => Left(failure),
      (model) async {
        // Guarda en caché
        await _localDatasource.cacheMovieDetail(movieId, model);
        return Right(MovieDetailMapper.toEntity(model));
      },
    );
  }

  @override
  Future<Either<AppException, List<MovieImageEntity>>> fetchMovieImages({
    required int movieId,
  }) async {
    // Cache-First Strategy: Primero intenta obtener de caché local
    final cachedImages = await _localDatasource.getCachedMovieImages(movieId);
    if (cachedImages != null && cachedImages.isNotEmpty) {
      return Right(cachedImages
          .map((model) => MovieImageMapper.toEntity(model))
          .toList());
    }

    // Si no hay caché, obtiene de la API remota
    final response = await _remoteDatasource.fetchMovieImages(movieId: movieId);

    return response.fold(
      (failure) => Left(failure),
      (listModel) async {
        // Guarda en caché
        await _localDatasource.cacheMovieImages(movieId, listModel);
        return Right(
            listModel.map((model) => MovieImageMapper.toEntity(model)).toList());
      },
    );
  }

  @override
  Future<Either<AppException, List<CastEntity>>> fetchMovieCredits({
    required int movieId,
    String? language = AppLanguage.spanish,
  }) async {
    // Cache-First Strategy: Primero intenta obtener de caché local
    final cachedCredits = await _localDatasource.getCachedMovieCredits(movieId);
    if (cachedCredits != null && cachedCredits.isNotEmpty) {
      return Right(
          cachedCredits.map((model) => CastMapper.toEntity(model)).toList());
    }

    // Si no hay caché, obtiene de la API remota
    final response = await _remoteDatasource.fetchMovieCredits(
      movieId: movieId,
      language: language,
    );

    return response.fold(
      (failure) => Left(failure),
      (listModel) async {
        // Guarda en caché
        await _localDatasource.cacheMovieCredits(movieId, listModel);
        return Right(
            listModel.map((model) => CastMapper.toEntity(model)).toList());
      },
    );
  }

  @override
  Future<Either<AppException, CreditDetailEntity>> fetchCreditDetail({
    required String creditId,
    String? language = AppLanguage.spanish,
  }) async {
    final response = await _remoteDatasource.fetchCreditDetail(
      creditId: creditId,
      language: language,
    );
    return response.map((model) => CreditDetailMapper.toEntity(model));
  }
}
