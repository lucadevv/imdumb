import 'package:flutter/material.dart';

/// Clase centralizada para todas las keys de widgets usadas en tests de integración
/// 
/// Siguiendo mejores prácticas: usar keys únicos para encontrar widgets fácilmente
/// en los tests de integración.
class AppKeys {
  AppKeys._();

  static final instance = AppKeys._();

  // Home Screen
  static const homeMenuButton = Key('home_menu_button');
  static const homeSearchButton = Key('home_search_button');

  // Movies List Screen
  static const moviesListBackButton = Key('movies_list_back_button');
  static const moviesListTitle = Key('movies_list_title');
  static const moviesListGrid = Key('movies_list_grid');
  static const moviesListScrollView = Key('movies_list_scroll_view');
  static const moviesListRefreshIndicator = Key('movies_list_refresh_indicator');

  // Movie Detail Screen
  static const movieDetailBackButton = Key('movie_detail_back_button');
  static const movieDetailRecommendButton = Key('movie_detail_recommend_button');
  static const movieDetailScrollView = Key('movie_detail_scroll_view');

  // Search Screen
  static const searchBackButton = Key('search_back_button');
  static const searchTextField = Key('search_text_field');
  static const searchGrid = Key('search_grid');
  static const searchScrollView = Key('search_scroll_view');

  // Home Sections - Titles
  static const topRatedSectionTitle = Key('top_rated_section_title');
  static const nowPlayingSectionTitle = Key('now_playing_section_title');
  static const popularMoviesSectionTitle = Key('popular_movies_section_title');
  
  // Home Sections - View More Buttons
  static const topRatedViewMoreButton = Key('top_rated_view_more_button');
  static const nowPlayingViewMoreButton = Key('now_playing_view_more_button');
  static const popularMoviesViewMoreButton = Key('popular_movies_view_more_button');
  
  // Home Sections - Lists (para scroll horizontal)
  static const topRatedMoviesList = Key('top_rated_movies_list');
  static const nowPlayingMoviesList = Key('now_playing_movies_list');
  static const popularMoviesList = Key('popular_movies_list');
  
  // Home Screen
  static const homeScrollView = Key('home_scroll_view');
  
  // Genre Sections - View More Buttons (dinámico por genre.id)
  static Key genreViewMoreButton(int genreId) => Key('genre_${genreId}_view_more_button');

  // Movie Poster Cards (dinámico por movie.id)
  static Key moviePosterCard(int movieId) => Key('movie_poster_card_$movieId');
}
