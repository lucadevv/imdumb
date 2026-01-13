import 'package:imdumb/features/home/data/models/genre_db_model.dart';

/// Fixtures (datos mockeados) para géneros
/// 
/// Contiene datos de ejemplo para usar en tests
class GenreFixtures {
  /// Género de ejemplo
  static GenreDbModel get actionGenre => GenreDbModel(
        id: 28,
        name: 'Acción',
      );

  /// Lista de géneros de ejemplo
  static List<GenreDbModel> get genres => [
        actionGenre,
        GenreDbModel(id: 12, name: 'Aventura'),
        GenreDbModel(id: 16, name: 'Animación'),
        GenreDbModel(id: 35, name: 'Comedia'),
        GenreDbModel(id: 80, name: 'Crimen'),
        GenreDbModel(id: 99, name: 'Documental'),
        GenreDbModel(id: 18, name: 'Drama'),
        GenreDbModel(id: 10751, name: 'Familia'),
        GenreDbModel(id: 14, name: 'Fantasía'),
        GenreDbModel(id: 36, name: 'Historia'),
      ];

  /// Respuesta JSON mockeada de la API para géneros
  static Map<String, dynamic> get genresJsonResponse => {
        'genres': genres.map((genre) => {
          'id': genre.id,
          'name': genre.name,
        }).toList(),
      };
}
