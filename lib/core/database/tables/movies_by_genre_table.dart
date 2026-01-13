import 'package:drift/drift.dart';

/// SOLID: Single Responsibility Principle (SRP)
///
/// Esta tabla tiene una única responsabilidad: definir la estructura de la tabla
/// para almacenar películas por género en la base de datos local.
/// Usa una clave compuesta (genreId + movieId) para permitir múltiples películas por género.

class MoviesByGenreTable extends Table {
  IntColumn get genreId => integer()();
  IntColumn get movieId => integer()();
  BoolColumn get adult => boolean().nullable()();
  TextColumn get backdropPath => text().nullable()();
  TextColumn get genreIds => text().nullable()();
  TextColumn get originalLanguage => text().nullable()();
  TextColumn get originalTitle => text().nullable()();
  TextColumn get overview => text().nullable()();
  RealColumn get popularity => real().nullable()();
  TextColumn get posterPath => text().nullable()();
  TextColumn get releaseDate => text().nullable()();
  TextColumn get title => text().nullable()();
  BoolColumn get video => boolean().nullable()();
  RealColumn get voteAverage => real().nullable()();
  IntColumn get voteCount => integer().nullable()();

  @override
  Set<Column> get primaryKey => {genreId, movieId};
}
