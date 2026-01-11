import 'package:dartz/dartz.dart';
import 'package:imdumb/core/utils/constans/app_language.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/movie_detail/domain/entities/cast_entity.dart';
import 'package:imdumb/features/movie_detail/domain/repository/movie_detail_repository.dart';

class FetchMovieCreditsUsecase {
  final MovieDetailRepository _repository;

  FetchMovieCreditsUsecase({required MovieDetailRepository repository})
      : _repository = repository;

  Future<Either<AppException, List<CastEntity>>> fetchMovieCredits({
    required int movieId,
    String? language = AppLanguage.spanish,
  }) async {
    return await _repository.fetchMovieCredits(
      movieId: movieId,
      language: language,
    );
  }
}
