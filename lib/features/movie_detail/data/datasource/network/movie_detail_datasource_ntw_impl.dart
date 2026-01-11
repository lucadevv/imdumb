import 'package:dartz/dartz.dart';
import 'package:imdumb/core/services/network/api_services.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/core/utils/exeptions/exception_handler.dart';
import 'package:imdumb/features/movie_detail/data/datasource/movie_detail_datasource.dart';
import 'package:imdumb/features/movie_detail/data/models/cast_db_model.dart';
import 'package:imdumb/features/movie_detail/data/models/credit_detail_db_model.dart';
import 'package:imdumb/features/movie_detail/data/models/movie_detail_db_model.dart';
import 'package:imdumb/features/movie_detail/data/models/movie_image_db_model.dart';

class MovieDetailDatasourceNtwImpl implements MovieDetailDatasource {
  final ApiServices _services;

  MovieDetailDatasourceNtwImpl({required ApiServices services})
      : _services = services;

  @override
  Future<Either<AppException, MovieDetailDbModel>> fetchMovieDetail({
    required int movieId,
    String? language = "es-ES",
  }) async {
    try {
      final response = await _services.get(
        '/movie/$movieId?language=$language',
      );
      return Right(MovieDetailDbModel.fromJson(response.data));
    } catch (e) {
      final appException = ExceptionHandler.handleException(e);
      ExceptionHandler.logException(
        appException,
        context: 'fetchMovieDetail',
      );
      return Left(appException);
    }
  }

  @override
  Future<Either<AppException, List<MovieImageDbModel>>> fetchMovieImages({
    required int movieId,
  }) async {
    try {
      final response = await _services.get('/movie/$movieId/images');
      final backdrops = response.data['backdrops'] as List<dynamic>? ?? [];
      return Right(
        backdrops
            .map((json) => MovieImageDbModel.fromJson(json as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      final appException = ExceptionHandler.handleException(e);
      ExceptionHandler.logException(
        appException,
        context: 'fetchMovieImages',
      );
      return Left(appException);
    }
  }

  @override
  Future<Either<AppException, List<CastDbModel>>> fetchMovieCredits({
    required int movieId,
    String? language = "es-ES",
  }) async {
    try {
      final response = await _services.get(
        '/movie/$movieId/credits?language=$language',
      );
      final cast = response.data['cast'] as List<dynamic>? ?? [];
      return Right(
        cast
            .map((json) => CastDbModel.fromJson(json as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      final appException = ExceptionHandler.handleException(e);
      ExceptionHandler.logException(
        appException,
        context: 'fetchMovieCredits',
      );
      return Left(appException);
    }
  }

  @override
  Future<Either<AppException, CreditDetailDbModel>> fetchCreditDetail({
    required String creditId,
    String? language = "es-ES",
  }) async {
    try {
      final response = await _services.get(
        '/credit/$creditId?language=$language',
      );
      return Right(CreditDetailDbModel.fromJson(response.data));
    } catch (e) {
      final appException = ExceptionHandler.handleException(e);
      ExceptionHandler.logException(
        appException,
        context: 'fetchCreditDetail',
      );
      return Left(appException);
    }
  }
}
