import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:imdumb/core/utils/constans/app_language.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/movies_list/domain/entities/movie_list_type.dart';
import 'package:imdumb/features/movies_list/domain/use_cases/fetch_movies_list_usecase.dart';

part 'movies_list_event.dart';
part 'movies_list_state.dart';

class MoviesListBloc extends Bloc<MoviesListEvent, MoviesListState> {
  final FetchMoviesListUsecase _fetchMoviesListUsecase;
  final MovieListType type;
  final int? genreId;

  MoviesListBloc({
    required FetchMoviesListUsecase fetchMoviesListUsecase,
    required this.type,
    this.genreId,
  })  : _fetchMoviesListUsecase = fetchMoviesListUsecase,
        super(MoviesListState.initial()) {
    on<FetchMoviesListEvent>(_fetchMoviesListEvent);
  }

  Future<void> _fetchMoviesListEvent(
    FetchMoviesListEvent event,
    Emitter<MoviesListState> emit,
  ) async {
    if (state.status == MoviesListStatus.loading) {
      return;
    }

    if (!event.isLoadMore) {
      emit(state.copyWith(
        status: MoviesListStatus.loading,
        movies: [],
        page: 1,
        hasMore: true,
      ));
    } else {
      emit(state.copyWith(status: MoviesListStatus.loading));
    }

    final response = await _fetchMoviesListUsecase.fetchMovies(
      type: type,
      genreId: genreId,
      page: event.page.toString(),
      language: AppLanguage.spanish,
    );

    await response.fold(
      (failure) async {
        String errorMessage = _getErrorMessage(failure);
        emit(
          state.copyWith(
            status: MoviesListStatus.failure,
            errorMessage: errorMessage,
          ),
        );
      },
      (movies) async {
        final updatedList =
            event.isLoadMore ? [...state.movies, ...movies] : movies;

        final hasMore = movies.isNotEmpty && movies.length >= 20;

        emit(
          state.copyWith(
            movies: updatedList,
            status: MoviesListStatus.success,
            page: event.page,
            hasMore: hasMore,
            errorMessage: null,
          ),
        );
      },
    );
  }

  String _getErrorMessage(AppException exception) {
    return exception.message;
  }
}
