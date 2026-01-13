/// SOLID: Single Responsibility Principle (SRP)
///
/// Este modelo tiene una única responsabilidad: representar un género de película
/// tanto para serialización JSON como para almacenamiento local con Drift.
///
/// Patrón aplicado: Data Transfer Object (DTO)
/// Usado para transferir datos entre las capas de la aplicación (API, Base de Datos, Dominio).
class GenreDbModel {
  final int? id;
  final String? name;

  GenreDbModel({this.id, this.name});

  GenreDbModel copyWith({int? id, String? name}) =>
      GenreDbModel(id: id ?? this.id, name: name ?? this.name);

  factory GenreDbModel.fromJson(Map<String, dynamic> json) =>
      GenreDbModel(id: json["id"], name: json["name"]);
}
