import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:imdumb/core/utils/constans/app_language.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_movies_by_genre_usecase.dart';

part 'genre_movies_event.dart';
part 'genre_movies_state.dart';

class GenreMoviesBloc extends Bloc<GenreMoviesEvent, GenreMoviesState> {
  final FetchMoviesByGenreUsecase _fetchMoviesByGenreUsecase;

  GenreMoviesBloc({
    required FetchMoviesByGenreUsecase fetchMoviesByGenreUsecase,
  })  : _fetchMoviesByGenreUsecase = fetchMoviesByGenreUsecase,
        super(GenreMoviesState.initial()) {
    on<FetchMoviesByGenreEvent>(_fetchMoviesByGenreEvent);
  }

  Future<void> _fetchMoviesByGenreEvent(
    FetchMoviesByGenreEvent event,
    Emitter<GenreMoviesState> emit,
  ) async {
    final currentState =
        state.movieStates[event.genreId] ?? GenreMovieStatus.initial;
    if (currentState == GenreMovieStatus.loading) {
      return;
    }

    if (!event.isLoadMore) {
      final updatedMovieStates =
          Map<int, GenreMovieStatus>.from(state.movieStates);
      updatedMovieStates[event.genreId] = GenreMovieStatus.loading;
      final updatedMovies = Map<int, List<PopularMovieEntity>>.from(
        state.moviesByGenre,
      );
      updatedMovies[event.genreId] = [];
      final updatedPages = Map<int, int>.from(state.pages);
      updatedPages[event.genreId] = 1;
      final updatedHasMore = Map<int, bool>.from(state.hasMore);
      updatedHasMore[event.genreId] = true;

      emit(state.copyWith(
        movieStates: updatedMovieStates,
        moviesByGenre: updatedMovies,
        pages: updatedPages,
        hasMore: updatedHasMore,
      ));
    } else {
      final updatedMovieStates =
          Map<int, GenreMovieStatus>.from(state.movieStates);
      updatedMovieStates[event.genreId] = GenreMovieStatus.loading;
      emit(state.copyWith(movieStates: updatedMovieStates));
    }

    final response = await _fetchMoviesByGenreUsecase.fetchMoviesByGenre(
      genreId: event.genreId,
      page: event.page.toString(),
      language: AppLanguage.spanish,
    );

    await response.fold(
      (failure) async {
        String errorMessage = _getErrorMessage(failure);
        final updatedMovieStates =
            Map<int, GenreMovieStatus>.from(state.movieStates);
        updatedMovieStates[event.genreId] = GenreMovieStatus.failure;
        final updatedErrors = Map<int, String?>.from(state.errors);
        updatedErrors[event.genreId] = errorMessage;

        emit(
          state.copyWith(
            movieStates: updatedMovieStates,
            errors: updatedErrors,
          ),
        );
      },
      (movies) async {
        final currentMovies = state.moviesByGenre[event.genreId] ?? [];
        final updatedList =
            event.isLoadMore ? [...currentMovies, ...movies] : movies;

        final hasMore = movies.isNotEmpty && movies.length >= 20;

        final updatedMovies = Map<int, List<PopularMovieEntity>>.from(
          state.moviesByGenre,
        );
        updatedMovies[event.genreId] = updatedList;
        final updatedMovieStates =
            Map<int, GenreMovieStatus>.from(state.movieStates);
        updatedMovieStates[event.genreId] = GenreMovieStatus.success;
        final updatedPages = Map<int, int>.from(state.pages);
        updatedPages[event.genreId] = event.page;
        final updatedHasMore = Map<int, bool>.from(state.hasMore);
        updatedHasMore[event.genreId] = hasMore;
        final updatedErrors = Map<int, String?>.from(state.errors);
        updatedErrors[event.genreId] = null;

        emit(
          state.copyWith(
            moviesByGenre: updatedMovies,
            movieStates: updatedMovieStates,
            pages: updatedPages,
            hasMore: updatedHasMore,
            errors: updatedErrors,
          ),
        );
      },
    );
  }

  String _getErrorMessage(AppException exception) {
    return exception.message;
  }
}
