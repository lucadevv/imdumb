import 'package:dartz/dartz.dart';
import 'package:imdumb/core/utils/constans/app_language.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/data/models/popular_movie_db_model.dart';
import 'package:imdumb/features/home/data/models/genre_db_model.dart';

abstract class HomeDatasource {
  Future<Either<AppException, List<PopularMovieDbModel>>>
  fetchAllPopularMovies({
    String page = "1",
    String? language = AppLanguage.spanish,
  });

  Future<Either<AppException, List<PopularMovieDbModel>>>
  fetchAllNowPlayingMovies({
    String page = "1",
    String? language = AppLanguage.spanish,
  });

  Future<Either<AppException, List<PopularMovieDbModel>>>
  fetchAllTopRatedMovies({
    String page = "1",
    String? language = AppLanguage.spanish,
  });

  Future<Either<AppException, List<GenreDbModel>>> fetchAllGenres({
    String? language = AppLanguage.spanish,
  });

  Future<Either<AppException, List<PopularMovieDbModel>>>
  fetchMoviesByGenre({
    required int genreId,
    String page = "1",
    String? language = AppLanguage.spanish,
  });
}
