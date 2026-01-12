import 'package:dartz/dartz.dart';
import 'package:imdumb/core/utils/constans/app_language.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/home/domain/repository/home_repository.dart';

/// SOLID: Single Responsibility Principle (SRP)
/// 
/// Este UseCase tiene una única responsabilidad: obtener películas populares.
/// No maneja UI, no maneja persistencia, solo encapsula la lógica de negocio
/// para obtener películas populares desde el repositorio.
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
