import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:imdumb/core/bloc/base_bloc_mixin.dart';
import 'package:imdumb/core/utils/constans/app_language.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_top_rated_movie_usecase.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState>
    with BaseBlocMixin {
  final FetchAllTopRatedMovieUsecase _fetchAllTopRatedMovieUsecase;

  TopRatedMoviesBloc({
    required FetchAllTopRatedMovieUsecase fetchAllTopRatedMovieUsecase,
  }) : _fetchAllTopRatedMovieUsecase = fetchAllTopRatedMovieUsecase,
       super(TopRatedMoviesState.initial()) {
    on<FetchTopRatedMoviesEvent>(_fetchTopRatedMoviesEvent);
  }

  Future<void> _fetchTopRatedMoviesEvent(
    FetchTopRatedMoviesEvent event,
    Emitter<TopRatedMoviesState> emit,
  ) async {
    if (state.status == TopRatedMoviesStatus.loading) {
      return;
    }

    if (!event.isLoadMore) {
      emit(
        state.copyWith(
          status: TopRatedMoviesStatus.loading,
          movies: [],
          page: 1,
          hasMore: true,
        ),
      );
    } else {
      emit(state.copyWith(status: TopRatedMoviesStatus.loading));
    }

    final response = await _fetchAllTopRatedMovieUsecase.fetchAllTopRatedMovies(
      page: event.page.toString(),
      language: AppLanguage.spanish,
    );

    await response.fold(
      (failure) async {
        String errorMessage = getErrorMessage(failure);
        emit(
          state.copyWith(
            status: TopRatedMoviesStatus.failure,
            errorMessage: errorMessage,
          ),
        );
      },
      (movies) async {
        final updatedList = event.isLoadMore
            ? [...state.movies, ...movies]
            : movies;

        final hasMore = movies.isNotEmpty && movies.length >= 20;

        emit(
          state.copyWith(
            movies: updatedList,
            status: TopRatedMoviesStatus.success,
            page: event.page,
            hasMore: hasMore,
            errorMessage: null,
          ),
        );
      },
    );
  }
}
