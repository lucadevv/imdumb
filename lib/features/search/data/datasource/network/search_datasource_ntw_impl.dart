import 'package:dartz/dartz.dart';
import 'package:imdumb/core/services/network/api_services.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/core/utils/exeptions/exception_handler.dart';
import 'package:imdumb/features/home/data/models/popular_movie_db_model.dart';
import 'package:imdumb/features/search/data/datasource/search_datasource.dart';

/// SOLID: Single Responsibility Principle (SRP)
///
/// Esta clase tiene una única responsabilidad: implementar la lógica
/// de obtención de datos de búsqueda desde la API. No maneja UI,
/// no maneja lógica de negocio, solo encapsula la comunicación con la API.
///
/// Patrón aplicado: Repository Pattern (Network Data Source)
/// Implementa la obtención de datos desde la red.
class SearchDatasourceNtwImpl implements SearchDatasource {
  final ApiServices _services;

  SearchDatasourceNtwImpl({required ApiServices services})
      : _services = services;

  @override
  Future<Either<AppException, List<PopularMovieDbModel>>> searchMovies({
    required String query,
    required String page,
    required String language,
  }) async {
    try {
      final response = await _services.get(
        '/search/movie',
        queryParameters: {
          'query': query,
          'include_adult': 'false',
          'language': language,
          'page': page,
        },
      );

      final results = response.data['results'] as List<dynamic>;
      final movies = results
          .map((json) => PopularMovieDbModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(movies);
    } catch (e) {
      final appException = ExceptionHandler.handleException(e);
      ExceptionHandler.logException(appException, context: 'searchMovies');
      return Left(appException);
    }
  }
}
