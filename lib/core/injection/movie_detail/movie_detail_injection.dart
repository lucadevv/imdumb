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
import 'package:imdumb/main.dart';

class MovieDetailInjection {
  final GetIt _getIt;

  MovieDetailInjection({required GetIt getIt}) : _getIt = getIt {
    _init();
  }

  void _init() {
    _getIt.registerLazySingleton<MovieDetailDatasource>(
      () => MovieDetailDatasourceNtwImpl(services: getIt<ApiServices>()),
    );
    _getIt.registerLazySingleton<MovieDetailRepository>(
      () => MovieDetailRepositoryImpl(datasource: getIt<MovieDetailDatasource>()),
    );
    _getIt.registerLazySingleton<FetchMovieDetailUsecase>(
      () => FetchMovieDetailUsecase(repository: getIt<MovieDetailRepository>()),
    );
    _getIt.registerLazySingleton<FetchMovieImagesUsecase>(
      () => FetchMovieImagesUsecase(repository: getIt<MovieDetailRepository>()),
    );
    _getIt.registerLazySingleton<FetchMovieCreditsUsecase>(
      () => FetchMovieCreditsUsecase(repository: getIt<MovieDetailRepository>()),
    );
    _getIt.registerLazySingleton<FetchCreditDetailUsecase>(
      () => FetchCreditDetailUsecase(repository: getIt<MovieDetailRepository>()),
    );
  }
}
