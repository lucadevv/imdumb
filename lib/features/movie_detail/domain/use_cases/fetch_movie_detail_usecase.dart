import 'package:dartz/dartz.dart';
import 'package:imdumb/core/utils/constans/app_language.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/movie_detail/domain/entities/movie_detail_entity.dart';
import 'package:imdumb/features/movie_detail/domain/repository/movie_detail_repository.dart';

class FetchMovieDetailUsecase {
  final MovieDetailRepository _repository;

  FetchMovieDetailUsecase({required MovieDetailRepository repository})
      : _repository = repository;

  Future<Either<AppException, MovieDetailEntity>> fetchMovieDetail({
    required int movieId,
    String? language = AppLanguage.spanish,
  }) async {
    return await _repository.fetchMovieDetail(
      movieId: movieId,
      language: language,
    );
  }
}
