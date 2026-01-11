import 'package:dartz/dartz.dart';
import 'package:imdumb/core/utils/constans/app_language.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/movie_detail/domain/entities/cast_entity.dart';
import 'package:imdumb/features/movie_detail/domain/entities/credit_detail_entity.dart';
import 'package:imdumb/features/movie_detail/domain/entities/movie_detail_entity.dart';
import 'package:imdumb/features/movie_detail/domain/entities/movie_image_entity.dart';

abstract class MovieDetailRepository {
  Future<Either<AppException, MovieDetailEntity>> fetchMovieDetail({
    required int movieId,
    String? language = AppLanguage.spanish,
  });

  Future<Either<AppException, List<MovieImageEntity>>> fetchMovieImages({
    required int movieId,
  });

  Future<Either<AppException, List<CastEntity>>> fetchMovieCredits({
    required int movieId,
    String? language = AppLanguage.spanish,
  });

  Future<Either<AppException, CreditDetailEntity>> fetchCreditDetail({
    required String creditId,
    String? language = AppLanguage.spanish,
  });
}
