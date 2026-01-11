import 'package:imdumb/core/utils/exeptions/mapper_exeption.dart';
import 'package:imdumb/features/movie_detail/data/models/credit_detail_db_model.dart';
import 'package:imdumb/features/movie_detail/domain/entities/credit_detail_entity.dart';

class CreditDetailMapper {
  static CreditDetailEntity toEntity(CreditDetailDbModel model) {
    _validateRequiredFields(model);

    return CreditDetailEntity(
      id: model.id ?? '',
      creditType: model.creditType,
      department: model.department,
      job: model.job,
      mediaType: model.mediaType,
      person: model.person != null
          ? CreditPersonMapper.toEntity(model.person!)
          : null,
      media: model.media != null
          ? CreditMediaMapper.toEntity(model.media!)
          : null,
    );
  }

  static void _validateRequiredFields(CreditDetailDbModel model) {
    if (model.id == null || model.id!.isEmpty) {
      throw MapperException('Credit id is required');
    }
  }
}

class CreditPersonMapper {
  static CreditPersonEntity toEntity(Map<String, dynamic> json) {
    return CreditPersonEntity(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      originalName: json['original_name'] as String?,
      profilePath: json['profile_path'] as String?,
      knownForDepartment: json['known_for_department'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
    );
  }
}

class CreditMediaMapper {
  static CreditMediaEntity toEntity(Map<String, dynamic> json) {
    return CreditMediaEntity(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String?,
      title: json['title'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      mediaType: json['media_type'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int?,
      releaseDate: json['release_date'] as String?,
      firstAirDate: json['first_air_date'] as String?,
      character: json['character'] as String?,
    );
  }
}
