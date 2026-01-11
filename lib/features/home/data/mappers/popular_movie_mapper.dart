import 'package:imdumb/core/utils/exeptions/mapper_exeption.dart';
import 'package:imdumb/features/home/data/models/popular_movie_db_model.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';

class PopularMovieMapper {
  static PopularMovieEntity toEntity(PopularMovieDbModel model) {
    _validateRequiredFields(model);

    return PopularMovieEntity(
      adult: model.adult ?? false,
      backdropPath: model.backdropPath,
      id: model.id ?? 0,
      originalLanguage: model.originalLanguage ?? 'en',
      originalTitle: model.originalTitle ?? '',
      overview: model.overview ?? '',
      popularity: model.popularity ?? 0.0,
      posterPath: model.posterPath,
      releaseDate: model.releaseDate,
      title: model.title ?? _generateTitleFromOriginal(model),
      video: model.video ?? false,
      voteAverage: model.voteAverage ?? 0.0,
      voteCount: model.voteCount ?? 0,
    );
  }

  static List<PopularMovieEntity> toEntityList(
    List<PopularMovieDbModel> models,
  ) {
    return models
        .where((model) => _isValidModel(model))
        .map((model) => toEntity(model))
        .toList();
  }

  static PopularMovieDbModel toDbModel(PopularMovieEntity entity) {
    return PopularMovieDbModel(
      adult: entity.adult,
      backdropPath: entity.backdropPath,
      id: entity.id,
      originalLanguage: entity.originalLanguage,
      originalTitle: entity.originalTitle,
      overview: entity.overview,
      popularity: entity.popularity,
      posterPath: entity.posterPath,
      releaseDate: entity.releaseDate,
      title: entity.title,
      video: entity.video,
      voteAverage: entity.voteAverage,
      voteCount: entity.voteCount,
    );
  }

  static List<PopularMovieDbModel> toDbModelList(
    List<PopularMovieEntity> entities,
  ) {
    return entities.map((entity) => toDbModel(entity)).toList();
  }

  static bool _isValidModel(PopularMovieDbModel model) {
    if (model.id == null) return false;

    if ((model.title == null || model.title!.isEmpty) &&
        (model.originalTitle == null || model.originalTitle!.isEmpty)) {
      return false;
    }

    return true;
  }

  static void _validateRequiredFields(PopularMovieDbModel model) {
    if (model.id == null) {
      throw MapperException('El campo id es requerido para PopularMovieEntity');
    }

    if ((model.title == null || model.title!.isEmpty) &&
        (model.originalTitle == null || model.originalTitle!.isEmpty)) {
      throw MapperException(
        'Se requiere al menos un título (title u originalTitle)',
      );
    }
  }

  static String _generateTitleFromOriginal(PopularMovieDbModel model) {
    if (model.originalTitle != null && model.originalTitle!.isNotEmpty) {
      return model.originalTitle!;
    }

    if (model.title != null && model.title!.isNotEmpty) {
      return model.title!;
    }

    return 'Película sin título';
  }

  static PopularMovieEntity fromJsonToEntity(Map<String, dynamic> json) {
    final model = PopularMovieDbModel.fromJson(json);
    return toEntity(model);
  }

  static List<PopularMovieEntity> fromJsonListToEntityList(
    List<dynamic> jsonList,
  ) {
    return jsonList
        .map((json) => PopularMovieDbModel.fromJson(json))
        .where(_isValidModel)
        .map((model) => toEntity(model))
        .toList();
  }
}

extension PopularMovieDbModelMapper on PopularMovieDbModel {
  PopularMovieEntity toEntity() => PopularMovieMapper.toEntity(this);
}

extension PopularMovieDbModelListMapper on List<PopularMovieDbModel> {
  List<PopularMovieEntity> toEntityList() =>
      PopularMovieMapper.toEntityList(this);
}

extension PopularMovieEntityMapper on PopularMovieEntity {
  PopularMovieDbModel toDbModel() => PopularMovieMapper.toDbModel(this);
}

extension PopularMovieEntityListMapper on List<PopularMovieEntity> {
  List<PopularMovieDbModel> toDbModelList() =>
      PopularMovieMapper.toDbModelList(this);
}
