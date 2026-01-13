/// Fixtures (datos mockeados) para detalle de película
/// 
/// Contiene datos de ejemplo para usar en tests
class MovieDetailFixtures {
  /// Respuesta JSON mockeada de la API para detalle de película
  /// Usa paths reales de TMDB para imágenes válidas
  static Map<String, dynamic> get movieDetailJsonResponse => {
        'id': 550,
        'title': 'Fight Club',
        'overview': '<p>A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy.</p>',
        'vote_average': 8.4,
        'vote_count': 25000,
        'release_date': '1999-10-15',
        'backdrop_path': '/hZkgoQYus5vegHoetLkUJqLlDJ5.jpg', // Fight Club backdrop real
        'poster_path': '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg', // Fight Club poster real
        'runtime': 139,
        'genres': [
          {'id': 18, 'name': 'Drama'},
          {'id': 53, 'name': 'Thriller'},
        ],
      };

  /// Respuesta JSON mockeada de la API para imágenes
  /// Usa paths reales de TMDB para imágenes válidas
  static Map<String, dynamic> get movieImagesJsonResponse => {
        'backdrops': [
          {'file_path': '/hZkgoQYus5vegHoetLkUJqLlDJ5.jpg'}, // Fight Club backdrop real
          {'file_path': '/fNG7i7RqMErkcqhohV2a6cV1Ehy.jpg'}, // The Matrix backdrop real
        ],
        'posters': [],
      };

  /// Respuesta JSON mockeada de la API para cast
  /// Usa paths reales de TMDB para imágenes válidas
  static Map<String, dynamic> get castJsonResponse => {
        'cast': [
          {
            'id': 287,
            'name': 'Brad Pitt',
            'character': 'Tyler Durden',
            'profile_path': '/cckcYc2v0yh1tc9QjRptd5S8g0r.jpg', // Brad Pitt profile real
          },
          {
            'id': 819,
            'name': 'Edward Norton',
            'character': 'The Narrator',
            'profile_path': '/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg', // Edward Norton profile real
          },
          {
            'id': 1100,
            'name': 'Helena Bonham Carter',
            'character': 'Marla Singer',
            'profile_path': '/DDeITcCpnBd0CkAIRPhggy9h5h.jpg', // Helena Bonham Carter profile real
          },
        ],
        'crew': [],
      };
}
