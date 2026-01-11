import 'package:dartz/dartz.dart';
import 'package:imdumb/core/utils/constans/app_language.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/movie_detail/data/models/cast_db_model.dart';
import 'package:imdumb/features/movie_detail/data/models/credit_detail_db_model.dart';
import 'package:imdumb/features/movie_detail/data/models/movie_detail_db_model.dart';
import 'package:imdumb/features/movie_detail/data/models/movie_image_db_model.dart';

abstract class MovieDetailDatasource {
  Future<Either<AppException, MovieDetailDbModel>> fetchMovieDetail({
    required int movieId,
    String? language = AppLanguage.spanish,
  });

  Future<Either<AppException, List<MovieImageDbModel>>> fetchMovieImages({
    required int movieId,
  });

  Future<Either<AppException, List<CastDbModel>>> fetchMovieCredits({
    required int movieId,
    String? language = AppLanguage.spanish,
  });

  Future<Either<AppException, CreditDetailDbModel>> fetchCreditDetail({
    required String creditId,
    String? language = AppLanguage.spanish,
  });
}
