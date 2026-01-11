import 'package:equatable/equatable.dart';
import 'package:imdumb/core/utils/extension/tmdb_image_extension.dart';

class MovieImageEntity extends Equatable {
  final String? filePath;

  const MovieImageEntity({
    this.filePath,
  });

  String? get imageUrlW780 => filePath.tmdbBackdropW780;
  String? get imageUrlW1280 => filePath.tmdbBackdropW1280;

  @override
  List<Object?> get props => [filePath];

  @override
  bool get stringify => true;
}
