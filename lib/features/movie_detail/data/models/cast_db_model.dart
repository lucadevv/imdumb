class CastDbModel {
  final int? id;
  final String? name;
  final String? character;
  final String? profilePath;

  CastDbModel({
    this.id,
    this.name,
    this.character,
    this.profilePath,
  });

  factory CastDbModel.fromJson(Map<String, dynamic> json) {
    return CastDbModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      character: json['character'] as String?,
      profilePath: json['profile_path'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'character': character,
      'profile_path': profilePath,
    };
  }
}
