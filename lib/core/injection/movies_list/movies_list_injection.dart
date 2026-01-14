import 'package:get_it/get_it.dart';
import 'package:imdumb/core/database/cache_database_service.dart';
import 'package:imdumb/core/database/sqflite_cache_database_service.dart';
import 'package:imdumb/core/services/network/api_services.dart';
import 'package:imdumb/features/movies_list/data/datasource/movies_list_datasource.dart';
import 'package:imdumb/features/movies_list/data/datasource/local/movies_list_local_datasource.dart';
import 'package:imdumb/features/movies_list/data/datasource/network/movies_list_datasource_ntw_impl.dart';
import 'package:imdumb/features/movies_list/data/repository/movies_list_repository_impl.dart';
import 'package:imdumb/features/movies_list/domain/repository/movies_list_repository.dart';
import 'package:imdumb/features/movies_list/domain/use_cases/fetch_movies_list_usecase.dart';

class MoviesListInjection {
  final GetIt _getIt;

  MoviesListInjection({required GetIt getIt}) : _getIt = getIt {
    _init();
  }

  void _init() {
    if (!_getIt.isRegistered<MoviesListDatasource>()) {
      _getIt.registerLazySingleton<MoviesListDatasource>(
        () => MoviesListDatasourceNtwImpl(services: _getIt<ApiServices>()),
      );
    }
    // Registrar CacheDatabaseService con implementación SQLite si no está registrado
    if (!_getIt.isRegistered<CacheDatabaseService>()) {
      _getIt.registerLazySingleton<CacheDatabaseService>(
        () => SqfliteCacheDatabaseService(),
      );
    }
    if (!_getIt.isRegistered<MoviesListLocalDataSource>()) {
      _getIt.registerLazySingleton<MoviesListLocalDataSource>(
        () => MoviesListLocalDataSource(cacheService: _getIt<CacheDatabaseService>()),
      );
    }
    if (!_getIt.isRegistered<MoviesListRepository>()) {
      _getIt.registerLazySingleton<MoviesListRepository>(
        () => MoviesListRepositoryImpl(
          remoteDatasource: _getIt<MoviesListDatasource>(),
          localDatasource: _getIt<MoviesListLocalDataSource>(),
        ),
      );
    }
    if (!_getIt.isRegistered<FetchMoviesListUsecase>()) {
      _getIt.registerLazySingleton<FetchMoviesListUsecase>(
        () =>
            FetchMoviesListUsecase(repository: _getIt<MoviesListRepository>()),
      );
    }
  }
}
