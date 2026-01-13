import 'package:dartz/dartz.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';

/// SOLID: Dependency Inversion Principle (DIP)
///
/// Esta interfaz abstracta define el contrato para el repositorio de búsqueda.
/// Las clases de alto nivel (use cases) dependen de esta abstracción,
/// no de implementaciones concretas. Esto permite cambiar la implementación
/// sin afectar el código cliente.
///
/// Patrón aplicado: Repository Pattern (Domain Layer)
/// Define el contrato para obtener datos de búsqueda, ocultando los detalles
/// de implementación de las fuentes de datos.
abstract class SearchRepository {
  /// Busca películas por query
  /// 
  /// [query] - Término de búsqueda
  /// [page] - Número de página
  /// [language] - Idioma de los resultados
  Future<Either<AppException, List<PopularMovieEntity>>> searchMovies({
    required String query,
    required String page,
    required String language,
  });
}
