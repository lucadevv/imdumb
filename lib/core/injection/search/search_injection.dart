import 'package:get_it/get_it.dart';
import 'package:imdumb/core/services/network/api_services.dart';
import 'package:imdumb/features/search/data/datasource/search_datasource.dart';
import 'package:imdumb/features/search/data/datasource/network/search_datasource_ntw_impl.dart';
import 'package:imdumb/features/search/data/repository/search_repository_impl.dart';
import 'package:imdumb/features/search/domain/repository/search_repository.dart';
import 'package:imdumb/features/search/domain/use_cases/fetch_search_movies_usecase.dart';

/// SOLID: Dependency Inversion Principle (DIP)
///
/// Esta clase gestiona la inyección de dependencias para la feature de búsqueda.
/// Registra todas las dependencias necesarias siguiendo el patrón de inyección
/// de dependencias, facilitando el testing y el mantenimiento.
///
/// Patrón aplicado: Dependency Injection (Service Locator Pattern)
/// Centraliza la creación y gestión de dependencias, facilitando
/// el cambio de implementaciones y las pruebas.
class SearchInjection {
  final GetIt _getIt;

  SearchInjection({required GetIt getIt}) : _getIt = getIt {
    _init();
  }

  void _init() {
    if (!_getIt.isRegistered<SearchDatasource>()) {
      _getIt.registerLazySingleton<SearchDatasource>(
        () => SearchDatasourceNtwImpl(services: _getIt<ApiServices>()),
      );
    }
    if (!_getIt.isRegistered<SearchRepository>()) {
      _getIt.registerLazySingleton<SearchRepository>(
        () => SearchRepositoryImpl(datasource: _getIt<SearchDatasource>()),
      );
    }
    if (!_getIt.isRegistered<FetchSearchMoviesUsecase>()) {
      _getIt.registerLazySingleton<FetchSearchMoviesUsecase>(
        () => FetchSearchMoviesUsecase(repository: _getIt<SearchRepository>()),
      );
    }
  }
}
