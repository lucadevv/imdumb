import 'package:dartz/dartz.dart';
import 'package:imdumb/core/utils/constans/app_language.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/movies_list/domain/entities/movie_list_type.dart';

abstract class MoviesListRepository {
  Future<Either<AppException, List<PopularMovieEntity>>> fetchMovies({
    required MovieListType type,
    int? genreId,
    String page = "1",
    String? language = AppLanguage.spanish,
  });
}
