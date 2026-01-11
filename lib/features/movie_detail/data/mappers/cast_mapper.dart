import 'package:imdumb/core/utils/exeptions/mapper_exeption.dart';
import 'package:imdumb/features/movie_detail/data/models/cast_db_model.dart';
import 'package:imdumb/features/movie_detail/domain/entities/cast_entity.dart';

class CastMapper {
  static CastEntity toEntity(CastDbModel model) {
    _validateRequiredFields(model);

    return CastEntity(
      id: model.id ?? 0,
      name: model.name ?? '',
      character: model.character,
      profilePath: model.profilePath,
    );
  }

  static List<CastEntity> toEntityList(List<CastDbModel> models) {
    return models
        .where((model) => _isValidModel(model))
        .map((model) => toEntity(model))
        .toList();
  }

  static bool _isValidModel(CastDbModel model) {
    return model.id != null && model.name != null && model.name!.isNotEmpty;
  }

  static void _validateRequiredFields(CastDbModel model) {
    if (model.id == null) {
      throw MapperException('Cast id is required');
    }
    if (model.name == null || model.name!.isEmpty) {
      throw MapperException('Cast name is required');
    }
  }
}

extension CastDbModelExtension on List<CastDbModel> {
  List<CastEntity> toEntityList() {
    return CastMapper.toEntityList(this);
  }
}
