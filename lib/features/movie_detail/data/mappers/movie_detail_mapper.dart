import 'package:imdumb/core/utils/exeptions/mapper_exeption.dart';
import 'package:imdumb/core/utils/helpers/date_parser.dart';
import 'package:imdumb/features/movie_detail/data/models/movie_detail_db_model.dart';
import 'package:imdumb/features/movie_detail/domain/entities/movie_detail_entity.dart';

class MovieDetailMapper {
  static MovieDetailEntity toEntity(MovieDetailDbModel model) {
    _validateRequiredFields(model);

    return MovieDetailEntity(
      id: model.id ?? 0,
      title: model.title ?? '',
      overview: model.overview ?? '',
      voteAverage: model.voteAverage ?? 0.0,
      voteCount: model.voteCount ?? 0,
      releaseDate: DateParser.parseReleaseDate(model.releaseDate),
      backdropPath: model.backdropPath,
      posterPath: model.posterPath,
      runtime: model.runtime,
      genres:
          model.genres
              ?.map((g) => g['name'] as String? ?? '')
              .where((name) => name.isNotEmpty)
              .toList() ??
          [],
    );
  }

  static void _validateRequiredFields(MovieDetailDbModel model) {
    if (model.id == null) {
      throw MapperException('Movie id is required');
    }
    if (model.title == null || model.title!.isEmpty) {
      throw MapperException('Movie title is required');
    }
    if (model.overview == null) {
      throw MapperException('Movie overview is required');
    }
  }
}
