/// Clase centralizada para todos los strings fijos (no dinámicos) de la aplicación
/// 
/// Siguiendo mejores prácticas: usar strings constantes para hacer los tests
/// más confiables, legibles y fáciles de mantener.
class AppStrings {
  AppStrings._();

  static final instance = AppStrings._();

  // Home Screen Sections
  static const topRated = 'Top Rated';
  static const nowPlaying = 'En Cartelera';
  static const popularMovies = 'Películas Populares';

  // Buttons
  static const viewMore = 'Ver más';
  static const recommend = 'Recomendar';
  static const retry = 'Reintentar';
  static const clear = 'Limpiar';

  // Search Screen
  static const searchHint = 'Buscar películas...';
  static const noResults = 'No se encontraron resultados';
  static const initialSearchMessage = 'Busca películas por título';

  // Movies List Screen
  static const noMoviesAvailable = 'No hay películas disponibles';
  static const errorLoadingMovies = 'Error al cargar las películas';

  // Movie Detail Screen
  static const recommendationSent = '¡Recomendación enviada con éxito!';
  static const noConnection = 'No tiene conexión a internet';

  // App Bar
  static const appTitle = 'IMDUMB';
}
