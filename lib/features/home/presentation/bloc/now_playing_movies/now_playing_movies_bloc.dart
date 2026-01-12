import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:imdumb/core/bloc/base_bloc_mixin.dart';
import 'package:imdumb/core/utils/constans/app_language.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_now_playing_movie_usecase.dart';

part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState>
    with BaseBlocMixin {
  final FetchAllNowPlayingMovieUsecase _fetchAllNowPlayingMovieUsecase;

  NowPlayingMoviesBloc({
    required FetchAllNowPlayingMovieUsecase fetchAllNowPlayingMovieUsecase,
  })  : _fetchAllNowPlayingMovieUsecase = fetchAllNowPlayingMovieUsecase,
        super(NowPlayingMoviesState.initial()) {
    on<FetchNowPlayingMoviesEvent>(_fetchNowPlayingMoviesEvent);
  }

  Future<void> _fetchNowPlayingMoviesEvent(
    FetchNowPlayingMoviesEvent event,
    Emitter<NowPlayingMoviesState> emit,
  ) async {
    if (state.status == NowPlayingMoviesStatus.loading) {
      return;
    }

    if (!event.isLoadMore) {
      emit(state.copyWith(
        status: NowPlayingMoviesStatus.loading,
        movies: [],
        page: 1,
        hasMore: true,
      ));
    } else {
      emit(state.copyWith(status: NowPlayingMoviesStatus.loading));
    }

    final response =
        await _fetchAllNowPlayingMovieUsecase.fetchAllNowPlayingMovies(
      page: event.page.toString(),
      language: AppLanguage.spanish,
    );

    await response.fold(
      (failure) async {
        String errorMessage = getErrorMessage(failure);
        emit(
          state.copyWith(
            status: NowPlayingMoviesStatus.failure,
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
            status: NowPlayingMoviesStatus.success,
            page: event.page,
            hasMore: hasMore,
            errorMessage: null,
          ),
        );
      },
    );
  }
}
