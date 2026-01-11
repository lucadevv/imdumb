import 'package:dartz/dartz.dart';
import 'package:imdumb/core/services/network/api_services.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/core/utils/exeptions/exception_handler.dart';
import 'package:imdumb/features/home/data/models/popular_movie_db_model.dart';
import 'package:imdumb/features/movies_list/data/datasource/movies_list_datasource.dart';
import 'package:imdumb/features/movies_list/domain/entities/movie_list_type.dart';

class MoviesListDatasourceNtwImpl implements MoviesListDatasource {
  final ApiServices _services;

  MoviesListDatasourceNtwImpl({required ApiServices services})
    : _services = services;

  @override
  Future<Either<AppException, List<PopularMovieDbModel>>> fetchMovies({
    required MovieListType type,
    int? genreId,
    String page = "1",
    String? language = "es-ES",
  }) async {
    try {
      String endpoint;
      switch (type) {
        case MovieListType.popular:
          endpoint = '/movie/popular?language=$language&page=$page';
          break;
        case MovieListType.nowPlaying:
          endpoint = '/movie/now_playing?language=$language&page=$page';
          break;
        case MovieListType.topRated:
          endpoint = '/movie/top_rated?language=$language&page=$page';
          break;
        case MovieListType.genre:
          endpoint =
              '/discover/movie?include_adult=false&include_video=false&language=$language&page=$page&sort_by=popularity.desc&with_genres=${genreId ?? ''}';
          break;
      }

      final response = await _services.get(endpoint);
      final data = response.data["results"] as List<dynamic>;
      return Right(
        data.map((json) => PopularMovieDbModel.fromJson(json)).toList(),
      );
    } catch (e) {
      final appException = ExceptionHandler.handleException(e);
      ExceptionHandler.logException(appException, context: 'fetchMovies');
      return Left(appException);
    }
  }
}
