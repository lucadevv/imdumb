import 'package:drift/drift.dart';

/// SOLID: Single Responsibility Principle (SRP)
///
/// Esta tabla tiene una única responsabilidad: definir la estructura de la tabla
/// para almacenar géneros de películas en la base de datos local.

class GenresTable extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
