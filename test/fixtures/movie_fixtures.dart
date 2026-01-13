import 'package:imdumb/features/home/data/models/popular_movie_db_model.dart';

/// Fixtures (datos mockeados) para películas
/// 
/// Contiene datos de ejemplo para usar en tests
class MovieFixtures {
  /// Película popular de ejemplo
  /// Usa paths reales de TMDB que se convertirán en URLs válidas
  static PopularMovieDbModel get popularMovie => PopularMovieDbModel(
        adult: false,
        backdropPath: '/hZkgoQYus5vegHoetLkUJqLlDJ5.jpg', // Fight Club backdrop real
        id: 550,
        originalLanguage: 'en',
        originalTitle: 'Fight Club',
        overview: 'A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy.',
        popularity: 100.0,
        posterPath: '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg', // Fight Club poster real
        releaseDate: DateTime(1999, 10, 15),
        title: 'Fight Club',
        video: false,
        voteAverage: 8.4,
        voteCount: 25000,
      );

  /// Lista base de películas populares de ejemplo
  /// Usa paths reales de TMDB para imágenes válidas
  static List<PopularMovieDbModel> get _baseMovies => [
        popularMovie,
        PopularMovieDbModel(
          adult: false,
          backdropPath: '/fNG7i7RqMErkcqhohV2a6cV1Ehy.jpg', // The Matrix backdrop real
          id: 603,
          originalLanguage: 'en',
          originalTitle: 'The Matrix',
          overview: 'A computer hacker learns about the true nature of reality.',
          popularity: 95.0,
          posterPath: '/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg', // The Matrix poster real
          releaseDate: DateTime(1999, 3, 31),
          title: 'The Matrix',
          video: false,
          voteAverage: 8.7,
          voteCount: 30000,
        ),
        PopularMovieDbModel(
          adult: false,
          backdropPath: '/s3TBrRGB1iav7gFOCNx3H31MoES.jpg', // Inception backdrop real
          id: 27205,
          originalLanguage: 'en',
          originalTitle: 'Inception',
          overview: 'A thief who steals corporate secrets through dream-sharing technology.',
          popularity: 90.0,
          posterPath: '/oYuLEt3zVCKq57qu2F8dT7NIa6f.jpg', // Inception poster real
          releaseDate: DateTime(2010, 7, 16),
          title: 'Inception',
          video: false,
          voteAverage: 8.8,
          voteCount: 35000,
        ),
      ];

  /// Lista completa de películas populares (200 películas para scroll infinito)
  /// Genera suficientes películas para probar paginación (10 páginas x 20 películas)
  static List<PopularMovieDbModel> get popularMovies {
    final movies = <PopularMovieDbModel>[];
    final baseMovies = _baseMovies;
    
    // Repetir las películas base y variar los IDs para tener suficientes datos
    for (int i = 0; i < 200; i++) {
      final baseMovie = baseMovies[i % baseMovies.length];
      final baseId = baseMovie.id ?? 0;
      final basePopularity = baseMovie.popularity ?? 0.0;
      final baseVoteAverage = baseMovie.voteAverage ?? 0.0;
      final baseVoteCount = baseMovie.voteCount ?? 0;
      
      movies.add(
        PopularMovieDbModel(
          adult: baseMovie.adult,
          backdropPath: baseMovie.backdropPath,
          id: baseId + (i * 1000), // IDs únicos
          originalLanguage: baseMovie.originalLanguage,
          originalTitle: '${baseMovie.originalTitle}${i > 0 ? ' $i' : ''}',
          overview: baseMovie.overview,
          popularity: basePopularity - (i * 0.5),
          posterPath: baseMovie.posterPath,
          releaseDate: baseMovie.releaseDate?.add(Duration(days: i * 365)),
          title: '${baseMovie.title}${i > 0 ? ' $i' : ''}',
          video: baseMovie.video,
          voteAverage: baseVoteAverage - (i * 0.1),
          voteCount: baseVoteCount - (i * 100),
        ),
      );
    }
    
    return movies;
  }

  /// Genera películas para una página específica (para paginación)
  static List<PopularMovieDbModel> getMoviesForPage(int page, {int perPage = 20}) {
    final allMovies = popularMovies;
    final startIndex = (page - 1) * perPage;
    final endIndex = startIndex + perPage;
    
    if (startIndex >= allMovies.length) {
      return []; // No hay más películas
    }
    
    return allMovies.sublist(
      startIndex,
      endIndex > allMovies.length ? allMovies.length : endIndex,
    );
  }

  /// Respuesta JSON mockeada de la API para películas populares
  /// Por defecto devuelve la primera página (20 películas)
  static Map<String, dynamic> popularMoviesJsonResponseForPage(int page) {
    final movies = getMoviesForPage(page, perPage: 20);
    return {
      'results': movies.map((movie) => _movieToJson(movie)).toList(),
      'page': page,
      'total_pages': 10,
      'total_results': 200,
    };
  }

  /// Respuesta JSON mockeada de la API para películas populares (página 1)
  static Map<String, dynamic> get popularMoviesJsonResponse => 
      popularMoviesJsonResponseForPage(1);

  /// Respuesta JSON mockeada de la API para una película
  static Map<String, dynamic> get movieJsonResponse => _movieToJson(popularMovie);

  /// Convierte un PopularMovieDbModel a JSON
  static Map<String, dynamic> _movieToJson(PopularMovieDbModel movie) {
    return {
      'adult': movie.adult,
      'backdrop_path': movie.backdropPath,
      'genre_ids': movie.genreIds ?? [],
      'id': movie.id,
      'original_language': movie.originalLanguage,
      'original_title': movie.originalTitle,
      'overview': movie.overview,
      'popularity': movie.popularity,
      'poster_path': movie.posterPath,
      'release_date': movie.releaseDate != null
          ? '${movie.releaseDate!.year}-${movie.releaseDate!.month.toString().padLeft(2, '0')}-${movie.releaseDate!.day.toString().padLeft(2, '0')}'
          : null,
      'title': movie.title,
      'video': movie.video,
      'vote_average': movie.voteAverage,
      'vote_count': movie.voteCount,
    };
  }
}
