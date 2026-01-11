class MovieImageDbModel {
  final String? filePath;

  MovieImageDbModel({
    this.filePath,
  });

  factory MovieImageDbModel.fromJson(Map<String, dynamic> json) {
    return MovieImageDbModel(
      filePath: json['file_path'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'file_path': filePath,
    };
  }
}
