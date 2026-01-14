import 'package:drift/drift.dart';

/// SOLID: Single Responsibility Principle (SRP)
///
/// Esta tabla tiene una única responsabilidad: definir la estructura de la tabla
/// para almacenar créditos (cast) de películas en la base de datos local.
///
/// Patrón aplicado: Table Definition (Drift)
/// Define la estructura de la tabla usando código Dart, generando SQL automáticamente.

class MovieCreditsTable extends Table {
  IntColumn get movieId => integer()();
  IntColumn get castId => integer()();
  TextColumn get name => text().nullable()();
  TextColumn get character => text().nullable()();
  TextColumn get profilePath => text().nullable()();

  @override
  Set<Column> get primaryKey => {movieId, castId};
}
