import 'package:dartz/dartz.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/movie_detail/domain/entities/movie_image_entity.dart';
import 'package:imdumb/features/movie_detail/domain/repository/movie_detail_repository.dart';

class FetchMovieImagesUsecase {
  final MovieDetailRepository _repository;

  FetchMovieImagesUsecase({required MovieDetailRepository repository})
      : _repository = repository;

  Future<Either<AppException, List<MovieImageEntity>>> fetchMovieImages({
    required int movieId,
  }) async {
    return await _repository.fetchMovieImages(movieId: movieId);
  }
}
