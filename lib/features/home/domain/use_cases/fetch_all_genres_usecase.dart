import 'package:dartz/dartz.dart';
import 'package:imdumb/core/utils/constans/app_language.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/domain/entities/genre_entity.dart';
import 'package:imdumb/features/home/domain/repository/home_repository.dart';

class FetchAllGenresUsecase {
  final HomeRepository _repository;

  FetchAllGenresUsecase({required HomeRepository repository})
      : _repository = repository;

  Future<Either<AppException, List<GenreEntity>>> fetchAllGenres({
    String? language = AppLanguage.spanish,
  }) async {
    return await _repository.fetchAllGenres(language: language);
  }
}
