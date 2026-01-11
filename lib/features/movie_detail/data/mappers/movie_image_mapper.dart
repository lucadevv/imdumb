import 'package:imdumb/features/movie_detail/data/models/movie_image_db_model.dart';
import 'package:imdumb/features/movie_detail/domain/entities/movie_image_entity.dart';

class MovieImageMapper {
  static MovieImageEntity toEntity(MovieImageDbModel model) {
    return MovieImageEntity(
      filePath: model.filePath,
    );
  }

  static List<MovieImageEntity> toEntityList(List<MovieImageDbModel> models) {
    return models.map((model) => toEntity(model)).toList();
  }
}

extension MovieImageDbModelExtension on List<MovieImageDbModel> {
  List<MovieImageEntity> toEntityList() {
    return MovieImageMapper.toEntityList(this);
  }
}
