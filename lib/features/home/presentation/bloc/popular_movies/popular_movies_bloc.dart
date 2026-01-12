import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:imdumb/core/bloc/base_bloc_mixin.dart';
import 'package:imdumb/core/utils/constans/app_language.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_popular_movie_usecase.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState>
    with BaseBlocMixin {
  final FetchAllPopularMovieUsecase _fetchAllPopularMovieUsecase;

  PopularMoviesBloc({
    required FetchAllPopularMovieUsecase fetchAllPopularMovieUsecase,
  })  : _fetchAllPopularMovieUsecase = fetchAllPopularMovieUsecase,
        super(PopularMoviesState.initial()) {
    on<FetchPopularMoviesEvent>(_fetchPopularMoviesEvent);
  }

  Future<void> _fetchPopularMoviesEvent(
    FetchPopularMoviesEvent event,
    Emitter<PopularMoviesState> emit,
  ) async {
    if (state.status == PopularMoviesStatus.loading) {
      return;
    }

    emit(state.copyWith(status: PopularMoviesStatus.loading));

    final response = await _fetchAllPopularMovieUsecase.fetchAllPopularMovies(
      page: "1",
      language: AppLanguage.spanish,
    );

    await response.fold(
      (failure) async {
        String errorMessage = getErrorMessage(failure);
        emit(
          state.copyWith(
            status: PopularMoviesStatus.failure,
            errorMessage: errorMessage,
          ),
        );
      },
      (movies) async {
        emit(
          state.copyWith(
            movies: movies,
            status: PopularMoviesStatus.success,
            errorMessage: null,
          ),
        );
      },
    );
  }
}
