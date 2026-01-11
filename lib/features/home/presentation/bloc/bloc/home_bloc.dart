import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:imdumb/core/utils/constans/app_language.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/home/domain/entities/genre_entity.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_popular_movie_usecase.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_now_playing_movie_usecase.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_top_rated_movie_usecase.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_genres_usecase.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_movies_by_genre_usecase.dart';
import 'package:imdumb/main.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchAllPopularMovieUsecase _fetchAllPopularMovieUsecase;
  final FetchAllNowPlayingMovieUsecase _fetchAllNowPlayingMovieUsecase;
  final FetchAllTopRatedMovieUsecase _fetchAllTopRatedMovieUsecase;
  final FetchAllGenresUsecase _fetchAllGenresUsecase;
  final FetchMoviesByGenreUsecase _fetchMoviesByGenreUsecase;
  HomeBloc({
    required FetchAllPopularMovieUsecase fetchAllPopularMovieUsecase,
    required FetchAllNowPlayingMovieUsecase fetchAllNowPlayingMovieUsecase,
    required FetchAllTopRatedMovieUsecase fetchAllTopRatedMovieUsecase,
    required FetchAllGenresUsecase fetchAllGenresUsecase,
    required FetchMoviesByGenreUsecase fetchMoviesByGenreUsecase,
  })  : _fetchAllPopularMovieUsecase = getIt<FetchAllPopularMovieUsecase>(),
        _fetchAllNowPlayingMovieUsecase = getIt<FetchAllNowPlayingMovieUsecase>(),
        _fetchAllTopRatedMovieUsecase = getIt<FetchAllTopRatedMovieUsecase>(),
        _fetchAllGenresUsecase = getIt<FetchAllGenresUsecase>(),
        _fetchMoviesByGenreUsecase = getIt<FetchMoviesByGenreUsecase>(),
        super(HomeState.initial()) {
    on<FetchAllPopularMovieEvent>(_fetchAllPopularMovieEvent);
    on<FetchAllNowPlayingMovieEvent>(_fetchAllNowPlayingMovieEvent);
    on<FetchAllTopRatedMovieEvent>(_fetchAllTopRatedMovieEvent);
    on<FetchAllGenresEvent>(_fetchAllGenresEvent);
    on<FetchMoviesByGenreEvent>(_fetchMoviesByGenreEvent);
  }

  Future<void> _fetchAllPopularMovieEvent(
    FetchAllPopularMovieEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state.popularMovieState == PopularMovieState.loading) {
      return;
    }

    emit(state.copyWith(popularMovieState: PopularMovieState.loading));

    final response = await _fetchAllPopularMovieUsecase.fetchAllPopularMovies(
      page: "1",
      language: AppLanguage.spanish,
    );

    await response.fold(
      (failure) async {
        String errorMessage = _getErrorMessage(failure);
        emit(
          state.copyWith(
            popularMovieState: PopularMovieState.failure,
            errorMessage: errorMessage,
          ),
        );
      },
      (movies) async {
        emit(
          state.copyWith(
            listMovie: movies,
            popularMovieState: PopularMovieState.success,
            errorMessage: null,
          ),
        );
      },
    );
  }

  Future<void> _fetchAllNowPlayingMovieEvent(
    FetchAllNowPlayingMovieEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state.nowPlayingMovieState == PopularMovieState.loading) {
      return;
    }

    if (!event.isLoadMore) {
      emit(state.copyWith(
        nowPlayingMovieState: PopularMovieState.loading,
        listNowPlayingMovie: [],
        nowPlayingPage: 1,
        hasMoreNowPlayingMovies: true,
      ));
    } else {
      emit(state.copyWith(nowPlayingMovieState: PopularMovieState.loading));
    }

    final response = await _fetchAllNowPlayingMovieUsecase.fetchAllNowPlayingMovies(
      page: event.page.toString(),
      language: AppLanguage.spanish,
    );

    await response.fold(
      (failure) async {
        String errorMessage = _getErrorMessage(failure);
        emit(
          state.copyWith(
            nowPlayingMovieState: PopularMovieState.failure,
            nowPlayingErrorMessage: errorMessage,
          ),
        );
      },
      (movies) async {
        final updatedList = event.isLoadMore
            ? [...state.listNowPlayingMovie, ...movies]
            : movies;
        
        final hasMore = movies.isNotEmpty && movies.length >= 20;

        emit(
          state.copyWith(
            listNowPlayingMovie: updatedList,
            nowPlayingMovieState: PopularMovieState.success,
            nowPlayingPage: event.page,
            hasMoreNowPlayingMovies: hasMore,
            nowPlayingErrorMessage: null,
          ),
        );
      },
    );
  }

  Future<void> _fetchAllTopRatedMovieEvent(
    FetchAllTopRatedMovieEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state.topRatedMovieState == PopularMovieState.loading) {
      return;
    }

    if (!event.isLoadMore) {
      emit(state.copyWith(
        topRatedMovieState: PopularMovieState.loading,
        listTopRatedMovie: [],
        topRatedPage: 1,
        hasMoreTopRatedMovies: true,
      ));
    } else {
      emit(state.copyWith(topRatedMovieState: PopularMovieState.loading));
    }

    final response = await _fetchAllTopRatedMovieUsecase.fetchAllTopRatedMovies(
      page: event.page.toString(),
      language: AppLanguage.spanish,
    );

    await response.fold(
      (failure) async {
        String errorMessage = _getErrorMessage(failure);
        emit(
          state.copyWith(
            topRatedMovieState: PopularMovieState.failure,
            topRatedErrorMessage: errorMessage,
          ),
        );
      },
      (movies) async {
        final updatedList = event.isLoadMore
            ? [...state.listTopRatedMovie, ...movies]
            : movies;

        final hasMore = movies.isNotEmpty && movies.length >= 20;

        emit(
          state.copyWith(
            listTopRatedMovie: updatedList,
            topRatedMovieState: PopularMovieState.success,
            topRatedPage: event.page,
            hasMoreTopRatedMovies: hasMore,
            topRatedErrorMessage: null,
          ),
        );
      },
    );
  }

  Future<void> _fetchAllGenresEvent(
    FetchAllGenresEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state.genresState == PopularMovieState.loading) {
      return;
    }

    emit(state.copyWith(genresState: PopularMovieState.loading));

    final response = await _fetchAllGenresUsecase.fetchAllGenres(
      language: AppLanguage.spanish,
    );

    await response.fold(
      (failure) async {
        String errorMessage = _getErrorMessage(failure);
        emit(
          state.copyWith(
            genresState: PopularMovieState.failure,
            genresErrorMessage: errorMessage,
          ),
        );
      },
      (genres) async {
        emit(
          state.copyWith(
            genres: genres,
            genresState: PopularMovieState.success,
            genresErrorMessage: null,
          ),
        );
      },
    );
  }

  Future<void> _fetchMoviesByGenreEvent(
    FetchMoviesByGenreEvent event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state.genreMovieStates[event.genreId] ?? PopularMovieState.initial;
    if (currentState == PopularMovieState.loading) {
      return;
    }

    if (!event.isLoadMore) {
      final updatedGenreMovieStates = Map<int, PopularMovieState>.from(state.genreMovieStates);
      updatedGenreMovieStates[event.genreId] = PopularMovieState.loading;
      final updatedMoviesByGenre = Map<int, List<PopularMovieEntity>>.from(state.moviesByGenre);
      updatedMoviesByGenre[event.genreId] = [];
      final updatedGenrePages = Map<int, int>.from(state.genrePages);
      updatedGenrePages[event.genreId] = 1;
      final updatedHasMoreByGenre = Map<int, bool>.from(state.hasMoreByGenre);
      updatedHasMoreByGenre[event.genreId] = true;

      emit(state.copyWith(
        genreMovieStates: updatedGenreMovieStates,
        moviesByGenre: updatedMoviesByGenre,
        genrePages: updatedGenrePages,
        hasMoreByGenre: updatedHasMoreByGenre,
      ));
    } else {
      final updatedGenreMovieStates = Map<int, PopularMovieState>.from(state.genreMovieStates);
      updatedGenreMovieStates[event.genreId] = PopularMovieState.loading;
      emit(state.copyWith(genreMovieStates: updatedGenreMovieStates));
    }

    final response = await _fetchMoviesByGenreUsecase.fetchMoviesByGenre(
      genreId: event.genreId,
      page: event.page.toString(),
      language: AppLanguage.spanish,
    );

    await response.fold(
      (failure) async {
        String errorMessage = _getErrorMessage(failure);
        final updatedGenreMovieStates = Map<int, PopularMovieState>.from(state.genreMovieStates);
        updatedGenreMovieStates[event.genreId] = PopularMovieState.failure;
        final updatedGenreErrors = Map<int, String?>.from(state.genreErrors);
        updatedGenreErrors[event.genreId] = errorMessage;

        emit(
          state.copyWith(
            genreMovieStates: updatedGenreMovieStates,
            genreErrors: updatedGenreErrors,
          ),
        );
      },
      (movies) async {
        final currentMovies = state.moviesByGenre[event.genreId] ?? [];
        final updatedList = event.isLoadMore ? [...currentMovies, ...movies] : movies;

        final hasMore = movies.isNotEmpty && movies.length >= 20;

        final updatedMoviesByGenre = Map<int, List<PopularMovieEntity>>.from(state.moviesByGenre);
        updatedMoviesByGenre[event.genreId] = updatedList;
        final updatedGenreMovieStates = Map<int, PopularMovieState>.from(state.genreMovieStates);
        updatedGenreMovieStates[event.genreId] = PopularMovieState.success;
        final updatedGenrePages = Map<int, int>.from(state.genrePages);
        updatedGenrePages[event.genreId] = event.page;
        final updatedHasMoreByGenre = Map<int, bool>.from(state.hasMoreByGenre);
        updatedHasMoreByGenre[event.genreId] = hasMore;
        final updatedGenreErrors = Map<int, String?>.from(state.genreErrors);
        updatedGenreErrors[event.genreId] = null;

        emit(
          state.copyWith(
            moviesByGenre: updatedMoviesByGenre,
            genreMovieStates: updatedGenreMovieStates,
            genrePages: updatedGenrePages,
            hasMoreByGenre: updatedHasMoreByGenre,
            genreErrors: updatedGenreErrors,
          ),
        );
      },
    );
  }

  String _getErrorMessage(AppException exception) {
    return exception.message;
  }
}
