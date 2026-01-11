import 'package:dartz/dartz.dart';
import 'package:imdumb/core/utils/constans/app_language.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/data/mappers/popular_movie_mapper.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/movies_list/data/datasource/movies_list_datasource.dart';
import 'package:imdumb/features/movies_list/domain/entities/movie_list_type.dart';
import 'package:imdumb/features/movies_list/domain/repository/movies_list_repository.dart';

class MoviesListRepositoryImpl implements MoviesListRepository {
  final MoviesListDatasource _datasource;

  MoviesListRepositoryImpl({required MoviesListDatasource datasource})
      : _datasource = datasource;

  @override
  Future<Either<AppException, List<PopularMovieEntity>>> fetchMovies({
    required MovieListType type,
    int? genreId,
    String page = "1",
    String? language = AppLanguage.spanish,
  }) async {
    final response = await _datasource.fetchMovies(
      type: type,
      genreId: genreId,
      page: page,
      language: language,
    );
    return response.map((listModel) => listModel.toEntityList());
  }
}
