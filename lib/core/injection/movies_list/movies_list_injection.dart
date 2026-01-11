import 'package:get_it/get_it.dart';
import 'package:imdumb/core/services/network/api_services.dart';
import 'package:imdumb/features/movies_list/data/datasource/movies_list_datasource.dart';
import 'package:imdumb/features/movies_list/data/datasource/network/movies_list_datasource_ntw_impl.dart';
import 'package:imdumb/features/movies_list/data/repository/movies_list_repository_impl.dart';
import 'package:imdumb/features/movies_list/domain/repository/movies_list_repository.dart';
import 'package:imdumb/features/movies_list/domain/use_cases/fetch_movies_list_usecase.dart';
import 'package:imdumb/main.dart';

class MoviesListInjection {
  final GetIt _getIt;

  MoviesListInjection({required GetIt getIt}) : _getIt = getIt {
    _init();
  }

  void _init() {
    _getIt.registerLazySingleton<MoviesListDatasource>(
      () => MoviesListDatasourceNtwImpl(services: getIt<ApiServices>()),
    );
    _getIt.registerLazySingleton<MoviesListRepository>(
      () => MoviesListRepositoryImpl(datasource: getIt<MoviesListDatasource>()),
    );
    _getIt.registerLazySingleton<FetchMoviesListUsecase>(
      () => FetchMoviesListUsecase(repository: getIt<MoviesListRepository>()),
    );
  }
}
