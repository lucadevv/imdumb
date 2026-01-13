import 'package:dartz/dartz.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/search/domain/repository/search_repository.dart';

/// SOLID: Single Responsibility Principle (SRP)
///
/// Este use case tiene una única responsabilidad: ejecutar la lógica
/// de búsqueda de películas. No maneja UI, no maneja datos directamente,
/// solo orquesta la búsqueda a través del repositorio.
///
/// Patrón aplicado: Use Case Pattern (Clean Architecture)
/// Encapsula una operación de negocio específica, haciendo el código
/// más testeable y mantenible.
class FetchSearchMoviesUsecase {
  final SearchRepository _repository;

  FetchSearchMoviesUsecase({required SearchRepository repository})
      : _repository = repository;

  Future<Either<AppException, List<PopularMovieEntity>>> execute({
    required String query,
    required String page,
    required String language,
  }) async {
    return await _repository.searchMovies(
      query: query,
      page: page,
      language: language,
    );
  }
}
