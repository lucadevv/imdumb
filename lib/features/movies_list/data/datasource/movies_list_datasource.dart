import 'package:dartz/dartz.dart';
import 'package:imdumb/core/utils/constans/app_language.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/data/models/popular_movie_db_model.dart';
import 'package:imdumb/features/movies_list/domain/entities/movie_list_type.dart';

abstract class MoviesListDatasource {
  Future<Either<AppException, List<PopularMovieDbModel>>> fetchMovies({
    required MovieListType type,
    int? genreId,
    String page = "1",
    String? language = AppLanguage.spanish,
  });
}
