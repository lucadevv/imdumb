import 'package:dartz/dartz.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/data/mappers/popular_movie_mapper.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/search/data/datasource/search_datasource.dart';
import 'package:imdumb/features/search/domain/repository/search_repository.dart';

/// SOLID: Single Responsibility Principle (SRP) & Dependency Inversion Principle (DIP)
///
/// Este repositorio tiene una única responsabilidad: coordinar entre
/// la fuente de datos (API) y la capa de dominio, transformando los datos
/// usando mappers.
///
/// Patrón aplicado: Repository Pattern
/// Oculta los detalles de implementación de las fuentes de datos,
/// proporcionando una interfaz limpia para la capa de dominio.
class SearchRepositoryImpl implements SearchRepository {
  final SearchDatasource _datasource;

  SearchRepositoryImpl({
    required SearchDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<Either<AppException, List<PopularMovieEntity>>> searchMovies({
    required String query,
    required String page,
    required String language,
  }) async {
    final response = await _datasource.searchMovies(
      query: query,
      page: page,
      language: language,
    );

    return response.fold(
      (failure) => Left(failure),
      (movies) => Right(PopularMovieMapper.toEntityList(movies)),
    );
  }
}
