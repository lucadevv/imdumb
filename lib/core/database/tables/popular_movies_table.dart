import 'package:drift/drift.dart';

/// SOLID: Single Responsibility Principle (SRP)
///
/// Esta tabla tiene una única responsabilidad: definir la estructura de la tabla
/// para almacenar películas populares en la base de datos local.
///
/// Patrón aplicado: Table Definition (Drift)
/// Define la estructura de la tabla usando código Dart, generando SQL automáticamente.

class PopularMoviesTable extends Table {
  IntColumn get id => integer()();
  BoolColumn get adult => boolean().nullable()();
  TextColumn get backdropPath => text().nullable()();
  TextColumn get genreIds => text().nullable()(); // Almacenado como JSON string
  TextColumn get originalLanguage => text().nullable()();
  TextColumn get originalTitle => text().nullable()();
  TextColumn get overview => text().nullable()();
  RealColumn get popularity => real().nullable()();
  TextColumn get posterPath => text().nullable()();
  TextColumn get releaseDate => text().nullable()(); // ISO 8601 string
  TextColumn get title => text().nullable()();
  BoolColumn get video => boolean().nullable()();
  RealColumn get voteAverage => real().nullable()();
  IntColumn get voteCount => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
