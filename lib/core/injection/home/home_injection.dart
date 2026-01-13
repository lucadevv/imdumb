import 'package:get_it/get_it.dart';
import 'package:imdumb/core/database/cache_database_service.dart';
import 'package:imdumb/core/database/sqflite_cache_database_service.dart';
import 'package:imdumb/core/services/network/api_services.dart';
import 'package:imdumb/features/home/data/datasource/home_datasource.dart';
import 'package:imdumb/features/home/data/datasource/local/home_local_datasource.dart';
import 'package:imdumb/features/home/data/datasource/network/home_datasource_ntw_impl.dart';
import 'package:imdumb/features/home/data/repository/home_repository_impl.dart';
import 'package:imdumb/features/home/domain/repository/home_repository.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_popular_movie_usecase.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_now_playing_movie_usecase.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_top_rated_movie_usecase.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_genres_usecase.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_movies_by_genre_usecase.dart';

class HomeInjection {
  final GetIt _getIt;

  HomeInjection({required GetIt getIt}) : _getIt = getIt {
    _init();
  }

  void _init() {
    if (!_getIt.isRegistered<HomeDatasource>()) {
      _getIt.registerLazySingleton<HomeDatasource>(
        () => HomeDatasourceNtwImpl(services: _getIt<ApiServices>()),
      );
    }
    // Registrar CacheDatabaseService con implementación SQLite
    if (!_getIt.isRegistered<CacheDatabaseService>()) {
      _getIt.registerLazySingleton<CacheDatabaseService>(
        () => SqfliteCacheDatabaseService(),
      );
    }
    if (!_getIt.isRegistered<HomeLocalDataSource>()) {
      _getIt.registerLazySingleton<HomeLocalDataSource>(
        () => HomeLocalDataSource(cacheService: _getIt<CacheDatabaseService>()),
      );
    }
    if (!_getIt.isRegistered<HomeRepository>()) {
      _getIt.registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImpl(
          remoteDatasource: _getIt<HomeDatasource>(),
          localDatasource: _getIt<HomeLocalDataSource>(),
        ),
      );
    }
    if (!_getIt.isRegistered<FetchAllPopularMovieUsecase>()) {
      _getIt.registerLazySingleton<FetchAllPopularMovieUsecase>(
        () => FetchAllPopularMovieUsecase(repository: _getIt<HomeRepository>()),
      );
    }
    if (!_getIt.isRegistered<FetchAllNowPlayingMovieUsecase>()) {
      _getIt.registerLazySingleton<FetchAllNowPlayingMovieUsecase>(
        () => FetchAllNowPlayingMovieUsecase(
          repository: _getIt<HomeRepository>(),
        ),
      );
    }
    if (!_getIt.isRegistered<FetchAllTopRatedMovieUsecase>()) {
      _getIt.registerLazySingleton<FetchAllTopRatedMovieUsecase>(
        () =>
            FetchAllTopRatedMovieUsecase(repository: _getIt<HomeRepository>()),
      );
    }
    if (!_getIt.isRegistered<FetchAllGenresUsecase>()) {
      _getIt.registerLazySingleton<FetchAllGenresUsecase>(
        () => FetchAllGenresUsecase(repository: _getIt<HomeRepository>()),
      );
    }
    if (!_getIt.isRegistered<FetchMoviesByGenreUsecase>()) {
      _getIt.registerLazySingleton<FetchMoviesByGenreUsecase>(
        () => FetchMoviesByGenreUsecase(repository: _getIt<HomeRepository>()),
      );
    }
  }
}
