import 'package:get_it/get_it.dart';
import 'package:imdumb/core/services/network/api_services.dart';
import 'package:imdumb/features/movie_detail/data/datasource/movie_detail_datasource.dart';
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
    if (!_getIt.isRegistered<MovieDetailRepository>()) {
      _getIt.registerLazySingleton<MovieDetailRepository>(
        () => MovieDetailRepositoryImpl(
          datasource: _getIt<MovieDetailDatasource>(),
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
