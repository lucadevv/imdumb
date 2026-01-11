class GenreDbModel {
  final int? id;
  final String? name;

  GenreDbModel({
    this.id,
    this.name,
  });

  GenreDbModel copyWith({
    int? id,
    String? name,
  }) =>
      GenreDbModel(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory GenreDbModel.fromJson(Map<String, dynamic> json) => GenreDbModel(
        id: json["id"],
        name: json["name"],
      );
}
