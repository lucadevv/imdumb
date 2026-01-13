import 'package:dartz/dartz.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/data/models/popular_movie_db_model.dart';

/// SOLID: Dependency Inversion Principle (DIP)
///
/// Esta interfaz abstracta define el contrato para el datasource de búsqueda.
/// Las clases de alto nivel (repositories) dependen de esta abstracción,
/// no de implementaciones concretas. Esto permite cambiar la implementación
/// (red, caché, mock, etc.) sin afectar el código cliente.
///
/// Patrón aplicado: Repository Pattern (Data Source Layer)
/// Separa la lógica de obtención de datos de la lógica de negocio.
abstract class SearchDatasource {
  /// Busca películas por query
  /// 
  /// [query] - Término de búsqueda
  /// [page] - Número de página
  /// [language] - Idioma de los resultados
  Future<Either<AppException, List<PopularMovieDbModel>>> searchMovies({
    required String query,
    required String page,
    required String language,
  });
}
