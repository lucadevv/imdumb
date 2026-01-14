import 'package:drift/drift.dart';

/// SOLID: Single Responsibility Principle (SRP)
///
/// Esta tabla tiene una única responsabilidad: definir la estructura de la tabla
/// para almacenar detalles de películas en la base de datos local.
///
/// Patrón aplicado: Table Definition (Drift)
/// Define la estructura de la tabla usando código Dart, generando SQL automáticamente.

class MovieDetailsTable extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text().nullable()();
  TextColumn get overview => text().nullable()();
  RealColumn get voteAverage => real().nullable()();
  IntColumn get voteCount => integer().nullable()();
  TextColumn get releaseDate => text().nullable()();
  TextColumn get backdropPath => text().nullable()();
  TextColumn get posterPath => text().nullable()();
  IntColumn get runtime => integer().nullable()();
  TextColumn get genres => text().nullable()(); // Almacenado como JSON string

  @override
  Set<Column> get primaryKey => {id};
}
