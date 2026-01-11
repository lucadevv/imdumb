import 'package:get_it/get_it.dart';
import 'package:imdumb/core/services/network/api_services.dart';
import 'package:imdumb/features/home/data/datasource/home_datasource.dart';
import 'package:imdumb/features/home/data/datasource/network/home_datasource_ntw_impl.dart';
import 'package:imdumb/features/home/data/repository/home_repository_impl.dart';
import 'package:imdumb/features/home/domain/repository/home_repository.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_popular_movie_usecase.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_now_playing_movie_usecase.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_top_rated_movie_usecase.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_genres_usecase.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_movies_by_genre_usecase.dart';
import 'package:imdumb/main.dart';

class HomeInjection {
  final GetIt _getIt;

  HomeInjection({required GetIt getIt}) : _getIt = getIt {
    _init();
  }

  void _init() {
    _getIt.registerLazySingleton<HomeDatasource>(
      () => HomeDatasourceNtwImpl(services: getIt<ApiServices>()),
    );
    _getIt.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(datasource: getIt<HomeDatasource>()),
    );
    _getIt.registerLazySingleton<FetchAllPopularMovieUsecase>(
      () => FetchAllPopularMovieUsecase(repository: getIt<HomeRepository>()),
    );
    _getIt.registerLazySingleton<FetchAllNowPlayingMovieUsecase>(
      () => FetchAllNowPlayingMovieUsecase(repository: getIt<HomeRepository>()),
    );
    _getIt.registerLazySingleton<FetchAllTopRatedMovieUsecase>(
      () => FetchAllTopRatedMovieUsecase(repository: getIt<HomeRepository>()),
    );
    _getIt.registerLazySingleton<FetchAllGenresUsecase>(
      () => FetchAllGenresUsecase(repository: getIt<HomeRepository>()),
    );
    _getIt.registerLazySingleton<FetchMoviesByGenreUsecase>(
      () => FetchMoviesByGenreUsecase(repository: getIt<HomeRepository>()),
    );
  }
}
