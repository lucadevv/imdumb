import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables/popular_movies_table.dart';
import 'tables/now_playing_movies_table.dart';
import 'tables/top_rated_movies_table.dart';
import 'tables/genres_table.dart';
import 'tables/movies_by_genre_table.dart';

part 'app_database.g.dart';

/// SOLID: Single Responsibility Principle (SRP)
///
/// Esta base de datos tiene una única responsabilidad: gestionar el almacenamiento
/// local de datos usando SQLite a través de Drift. Proporciona acceso a todas las
/// tablas de la aplicación de forma centralizada.
///
/// Patrón aplicado: Repository Pattern (Database Layer)
/// Centraliza el acceso a la base de datos y facilita el mantenimiento y las pruebas.

@DriftDatabase(tables: [
  PopularMoviesTable,
  NowPlayingMoviesTable,
  TopRatedMoviesTable,
  GenresTable,
  MoviesByGenreTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Implementar migraciones si es necesario en el futuro
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.db'));
    return NativeDatabase(file);
  });
}
