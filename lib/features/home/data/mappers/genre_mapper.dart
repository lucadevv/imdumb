import 'package:imdumb/core/utils/exeptions/mapper_exeption.dart';
import 'package:imdumb/features/home/data/models/genre_db_model.dart';
import 'package:imdumb/features/home/domain/entities/genre_entity.dart';

class GenreMapper {
  static GenreEntity toEntity(GenreDbModel model) {
    _validateRequiredFields(model);

    return GenreEntity(
      id: model.id ?? 0,
      name: model.name ?? '',
    );
  }

  static List<GenreEntity> toEntityList(List<GenreDbModel> models) {
    return models
        .where((model) => _isValidModel(model))
        .map((model) => toEntity(model))
        .toList();
  }

  static bool _isValidModel(GenreDbModel model) {
    return model.id != null && model.name != null && model.name!.isNotEmpty;
  }

  static void _validateRequiredFields(GenreDbModel model) {
    if (model.id == null) {
      throw MapperException('Genre id is required');
    }
    if (model.name == null || model.name!.isEmpty) {
      throw MapperException('Genre name is required');
    }
  }
}

extension GenreDbModelExtension on List<GenreDbModel> {
  List<GenreEntity> toEntityList() {
    return GenreMapper.toEntityList(this);
  }
}
