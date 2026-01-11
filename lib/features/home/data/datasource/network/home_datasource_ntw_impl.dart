import 'package:dartz/dartz.dart';
import 'package:imdumb/core/services/network/api_services.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/core/utils/exeptions/exception_handler.dart';
import 'package:imdumb/features/home/data/datasource/home_datasource.dart';
import 'package:imdumb/features/home/data/models/popular_movie_db_model.dart';
import 'package:imdumb/features/home/data/models/genre_db_model.dart';

class HomeDatasourceNtwImpl implements HomeDatasource {
  final ApiServices _services;

  HomeDatasourceNtwImpl({required ApiServices services}) : _services = services;

  @override
  Future<Either<AppException, List<PopularMovieDbModel>>>
  fetchAllPopularMovies({String page = "1", String? language = "es-ES"}) async {
    try {
      final response = await _services.get(
        '/movie/popular?language=$language&page=$page',
      );
      final data = response.data["results"] as List<dynamic>;
      return Right(
        data.map((json) => PopularMovieDbModel.fromJson(json)).toList(),
      );
    } catch (e) {
      final appException = ExceptionHandler.handleException(e);
      ExceptionHandler.logException(
        appException,
        context: 'fetchAllPopularMovies',
      );
      return Left(appException);
    }
  }

  @override
  Future<Either<AppException, List<PopularMovieDbModel>>>
  fetchAllNowPlayingMovies({String page = "1", String? language = "es-ES"}) async {
    try {
      final response = await _services.get(
        '/movie/now_playing?language=$language&page=$page',
      );
      final data = response.data["results"] as List<dynamic>;
      return Right(
        data.map((json) => PopularMovieDbModel.fromJson(json)).toList(),
      );
    } catch (e) {
      final appException = ExceptionHandler.handleException(e);
      ExceptionHandler.logException(
        appException,
        context: 'fetchAllNowPlayingMovies',
      );
      return Left(appException);
    }
  }

  @override
  Future<Either<AppException, List<PopularMovieDbModel>>>
  fetchAllTopRatedMovies({String page = "1", String? language = "es-ES"}) async {
    try {
      final response = await _services.get(
        '/movie/top_rated?language=$language&page=$page',
      );
      final data = response.data["results"] as List<dynamic>;
      return Right(
        data.map((json) => PopularMovieDbModel.fromJson(json)).toList(),
      );
    } catch (e) {
      final appException = ExceptionHandler.handleException(e);
      ExceptionHandler.logException(
        appException,
        context: 'fetchAllTopRatedMovies',
      );
      return Left(appException);
    }
  }

  @override
  Future<Either<AppException, List<GenreDbModel>>> fetchAllGenres({
    String? language = "es-ES",
  }) async {
    try {
      final response = await _services.get(
        '/genre/movie/list?language=$language',
      );
      final data = response.data["genres"] as List<dynamic>;
      return Right(
        data.map((json) => GenreDbModel.fromJson(json)).toList(),
      );
    } catch (e) {
      final appException = ExceptionHandler.handleException(e);
      ExceptionHandler.logException(
        appException,
        context: 'fetchAllGenres',
      );
      return Left(appException);
    }
  }

  @override
  Future<Either<AppException, List<PopularMovieDbModel>>>
  fetchMoviesByGenre({
    required int genreId,
    String page = "1",
    String? language = "es-ES",
  }) async {
    try {
      final response = await _services.get(
        '/discover/movie?with_genres=$genreId&language=$language&page=$page&sort_by=popularity.desc',
      );
      final data = response.data["results"] as List<dynamic>;
      return Right(
        data.map((json) => PopularMovieDbModel.fromJson(json)).toList(),
      );
    } catch (e) {
      final appException = ExceptionHandler.handleException(e);
      ExceptionHandler.logException(
        appException,
        context: 'fetchMoviesByGenre',
      );
      return Left(appException);
    }
  }
}
