import 'package:dartz/dartz.dart';
import 'package:imdumb/core/utils/constans/app_language.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/home/domain/repository/home_repository.dart';

class FetchAllPopularMovieUsecase {
  final HomeRepository _repository;

  FetchAllPopularMovieUsecase({required HomeRepository repository})
    : _repository = repository;

  Future<Either<AppException, List<PopularMovieEntity>>> fetchAllPopularMovies({
    String page = "1",
    String? language = AppLanguage.spanish,
  }) async {
    return await _repository.fetchAllPopularMovies();
  }
}
