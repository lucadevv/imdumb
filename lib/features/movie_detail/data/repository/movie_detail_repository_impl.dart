import 'package:dartz/dartz.dart';
import 'package:imdumb/core/utils/constans/app_language.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/movie_detail/data/datasource/movie_detail_datasource.dart';
import 'package:imdumb/features/movie_detail/data/mappers/cast_mapper.dart';
import 'package:imdumb/features/movie_detail/data/mappers/credit_detail_mapper.dart';
import 'package:imdumb/features/movie_detail/data/mappers/movie_detail_mapper.dart';
import 'package:imdumb/features/movie_detail/data/mappers/movie_image_mapper.dart';
import 'package:imdumb/features/movie_detail/domain/entities/cast_entity.dart';
import 'package:imdumb/features/movie_detail/domain/entities/credit_detail_entity.dart';
import 'package:imdumb/features/movie_detail/domain/entities/movie_detail_entity.dart';
import 'package:imdumb/features/movie_detail/domain/entities/movie_image_entity.dart';
import 'package:imdumb/features/movie_detail/domain/repository/movie_detail_repository.dart';

class MovieDetailRepositoryImpl implements MovieDetailRepository {
  final MovieDetailDatasource _datasource;

  MovieDetailRepositoryImpl({required MovieDetailDatasource datasource})
      : _datasource = datasource;

  @override
  Future<Either<AppException, MovieDetailEntity>> fetchMovieDetail({
    required int movieId,
    String? language = AppLanguage.spanish,
  }) async {
    final response = await _datasource.fetchMovieDetail(
      movieId: movieId,
      language: language,
    );
    return response.map((model) => MovieDetailMapper.toEntity(model));
  }

  @override
  Future<Either<AppException, List<MovieImageEntity>>> fetchMovieImages({
    required int movieId,
  }) async {
    final response = await _datasource.fetchMovieImages(movieId: movieId);
    return response.map((listModel) =>
        listModel.map((model) => MovieImageMapper.toEntity(model)).toList());
  }

  @override
  Future<Either<AppException, List<CastEntity>>> fetchMovieCredits({
    required int movieId,
    String? language = AppLanguage.spanish,
  }) async {
    final response = await _datasource.fetchMovieCredits(
      movieId: movieId,
      language: language,
    );
    return response.map((listModel) =>
        listModel.map((model) => CastMapper.toEntity(model)).toList());
  }

  @override
  Future<Either<AppException, CreditDetailEntity>> fetchCreditDetail({
    required String creditId,
    String? language = AppLanguage.spanish,
  }) async {
    final response = await _datasource.fetchCreditDetail(
      creditId: creditId,
      language: language,
    );
    return response.map((model) => CreditDetailMapper.toEntity(model));
  }
}
