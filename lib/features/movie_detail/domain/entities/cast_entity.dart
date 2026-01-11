import 'package:equatable/equatable.dart';
import 'package:imdumb/core/utils/extension/tmdb_image_extension.dart';

class CastEntity extends Equatable {
  final int id;
  final String name;
  final String? character;
  final String? profilePath;

  const CastEntity({
    required this.id,
    required this.name,
    this.character,
    this.profilePath,
  });

  String? get profileUrlW185 => profilePath.tmdbW185;

  @override
  List<Object?> get props => [id, name, character, profilePath];

  @override
  bool get stringify => true;
}
