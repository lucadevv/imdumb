import 'package:drift/drift.dart';

/// SOLID: Single Responsibility Principle (SRP)
///
/// Esta tabla tiene una única responsabilidad: definir la estructura de la tabla
/// para almacenar imágenes de películas en la base de datos local.
///
/// Patrón aplicado: Table Definition (Drift)
/// Define la estructura de la tabla usando código Dart, generando SQL automáticamente.

class MovieImagesTable extends Table {
  IntColumn get movieId => integer()();
  TextColumn get filePath => text()();

  @override
  Set<Column> get primaryKey => {movieId, filePath};
}
