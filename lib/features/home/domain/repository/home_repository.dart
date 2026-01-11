import 'package:dartz/dartz.dart';
import 'package:imdumb/core/utils/constans/app_language.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/home/domain/entities/genre_entity.dart';

abstract class HomeRepository {
  Future<Either<AppException, List<PopularMovieEntity>>> fetchAllPopularMovies({
    String page = "1",
    String? language = AppLanguage.spanish,
  });

  Future<Either<AppException, List<PopularMovieEntity>>> fetchAllNowPlayingMovies({
    String page = "1",
    String? language = AppLanguage.spanish,
  });

  Future<Either<AppException, List<PopularMovieEntity>>> fetchAllTopRatedMovies({
    String page = "1",
    String? language = AppLanguage.spanish,
  });

  Future<Either<AppException, List<GenreEntity>>> fetchAllGenres({
    String? language = AppLanguage.spanish,
  });

  Future<Either<AppException, List<PopularMovieEntity>>> fetchMoviesByGenre({
    required int genreId,
    String page = "1",
    String? language = AppLanguage.spanish,
  });
}
