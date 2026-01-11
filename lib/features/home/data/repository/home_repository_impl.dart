import 'package:dartz/dartz.dart';
import 'package:imdumb/core/utils/constans/app_language.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/data/datasource/home_datasource.dart';
import 'package:imdumb/features/home/data/mappers/popular_movie_mapper.dart';
import 'package:imdumb/features/home/data/mappers/genre_mapper.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/home/domain/entities/genre_entity.dart';
import 'package:imdumb/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource _datasource;

  HomeRepositoryImpl({required HomeDatasource datasource})
    : _datasource = datasource;
  @override
  Future<Either<AppException, List<PopularMovieEntity>>> fetchAllPopularMovies({
    String page = "1",
    String? language = AppLanguage.spanish,
  }) async {
    final response = await _datasource.fetchAllPopularMovies(
      page: page,
      language: language,
    );
    return response.map((listModel) => listModel.toEntityList());
  }

  @override
  Future<Either<AppException, List<PopularMovieEntity>>> fetchAllNowPlayingMovies({
    String page = "1",
    String? language = AppLanguage.spanish,
  }) async {
    final response = await _datasource.fetchAllNowPlayingMovies(
      page: page,
      language: language,
    );
    return response.map((listModel) => listModel.toEntityList());
  }

  @override
  Future<Either<AppException, List<PopularMovieEntity>>> fetchAllTopRatedMovies({
    String page = "1",
    String? language = AppLanguage.spanish,
  }) async {
    final response = await _datasource.fetchAllTopRatedMovies(
      page: page,
      language: language,
    );
    return response.map((listModel) => listModel.toEntityList());
  }

  @override
  Future<Either<AppException, List<GenreEntity>>> fetchAllGenres({
    String? language = AppLanguage.spanish,
  }) async {
    final response = await _datasource.fetchAllGenres(language: language);
    return response.map((listModel) => listModel.toEntityList());
  }

  @override
  Future<Either<AppException, List<PopularMovieEntity>>> fetchMoviesByGenre({
    required int genreId,
    String page = "1",
    String? language = AppLanguage.spanish,
  }) async {
    final response = await _datasource.fetchMoviesByGenre(
      genreId: genreId,
      page: page,
      language: language,
    );
    return response.map((listModel) => listModel.toEntityList());
  }
}
