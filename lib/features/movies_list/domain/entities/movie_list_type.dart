enum MovieListType {
  popular,
  nowPlaying,
  topRated,
  genre,
}

extension MovieListTypeExtension on MovieListType {
  String get title {
    switch (this) {
      case MovieListType.popular:
        return 'Películas Populares';
      case MovieListType.nowPlaying:
        return 'En Cartelera';
      case MovieListType.topRated:
        return 'Top Rated';
      case MovieListType.genre:
        return 'Películas por Género';
    }
  }
}
