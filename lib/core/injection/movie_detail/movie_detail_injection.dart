import 'package:get_it/get_it.dart';
import 'package:imdumb/core/database/cache_database_service.dart';
import 'package:imdumb/core/database/sqflite_cache_database_service.dart';
import 'package:imdumb/core/services/network/api_services.dart';
import 'package:imdumb/features/movie_detail/data/datasource/movie_detail_datasource.dart';
import 'package:imdumb/features/movie_detail/data/datasource/local/movie_detail_local_datasource.dart';
import 'package:imdumb/features/movie_detail/data/datasource/network/movie_detail_datasource_ntw_impl.dart';
import 'package:imdumb/features/movie_detail/data/repository/movie_detail_repository_impl.dart';
import 'package:imdumb/features/movie_detail/domain/repository/movie_detail_repository.dart';
import 'package:imdumb/features/movie_detail/domain/use_cases/fetch_credit_detail_usecase.dart';
import 'package:imdumb/features/movie_detail/domain/use_cases/fetch_movie_credits_usecase.dart';
import 'package:imdumb/features/movie_detail/domain/use_cases/fetch_movie_detail_usecase.dart';
import 'package:imdumb/features/movie_detail/domain/use_cases/fetch_movie_images_usecase.dart';

class MovieDetailInjection {
  final GetIt _getIt;

  MovieDetailInjection({required GetIt getIt}) : _getIt = getIt {
    _init();
  }

  void _init() {
    if (!_getIt.isRegistered<MovieDetailDatasource>()) {
      _getIt.registerLazySingleton<MovieDetailDatasource>(
        () => MovieDetailDatasourceNtwImpl(services: _getIt<ApiServices>()),
      );
    }
    // Registrar CacheDatabaseService con implementación SQLite si no está registrado
    if (!_getIt.isRegistered<CacheDatabaseService>()) {
      _getIt.registerLazySingleton<CacheDatabaseService>(
        () => SqfliteCacheDatabaseService(),
      );
    }
    if (!_getIt.isRegistered<MovieDetailLocalDataSource>()) {
      _getIt.registerLazySingleton<MovieDetailLocalDataSource>(
        () => MovieDetailLocalDataSource(cacheService: _getIt<CacheDatabaseService>()),
      );
    }
    if (!_getIt.isRegistered<MovieDetailRepository>()) {
      _getIt.registerLazySingleton<MovieDetailRepository>(
        () => MovieDetailRepositoryImpl(
          remoteDatasource: _getIt<MovieDetailDatasource>(),
          localDatasource: _getIt<MovieDetailLocalDataSource>(),
        ),
      );
    }
    if (!_getIt.isRegistered<FetchMovieDetailUsecase>()) {
      _getIt.registerLazySingleton<FetchMovieDetailUsecase>(
        () => FetchMovieDetailUsecase(
          repository: _getIt<MovieDetailRepository>(),
        ),
      );
    }
    if (!_getIt.isRegistered<FetchMovieImagesUsecase>()) {
      _getIt.registerLazySingleton<FetchMovieImagesUsecase>(
        () => FetchMovieImagesUsecase(
          repository: _getIt<MovieDetailRepository>(),
        ),
      );
    }
    if (!_getIt.isRegistered<FetchMovieCreditsUsecase>()) {
      _getIt.registerLazySingleton<FetchMovieCreditsUsecase>(
        () => FetchMovieCreditsUsecase(
          repository: _getIt<MovieDetailRepository>(),
        ),
      );
    }
    if (!_getIt.isRegistered<FetchCreditDetailUsecase>()) {
      _getIt.registerLazySingleton<FetchCreditDetailUsecase>(
        () => FetchCreditDetailUsecase(
          repository: _getIt<MovieDetailRepository>(),
        ),
      );
    }
  }
}
