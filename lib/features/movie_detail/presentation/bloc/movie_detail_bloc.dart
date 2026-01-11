import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:imdumb/core/utils/constans/app_language.dart';
import 'package:imdumb/features/movie_detail/domain/entities/cast_entity.dart';
import 'package:imdumb/features/movie_detail/domain/entities/movie_detail_entity.dart';
import 'package:imdumb/features/movie_detail/domain/entities/movie_image_entity.dart';
import 'package:imdumb/features/movie_detail/domain/use_cases/fetch_movie_credits_usecase.dart';
import 'package:imdumb/features/movie_detail/domain/use_cases/fetch_movie_detail_usecase.dart';
import 'package:imdumb/features/movie_detail/domain/use_cases/fetch_movie_images_usecase.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final FetchMovieDetailUsecase _fetchMovieDetailUsecase;
  final FetchMovieImagesUsecase _fetchMovieImagesUsecase;
  final FetchMovieCreditsUsecase _fetchMovieCreditsUsecase;
  final int movieId;

  MovieDetailBloc({
    required FetchMovieDetailUsecase fetchMovieDetailUsecase,
    required FetchMovieImagesUsecase fetchMovieImagesUsecase,
    required FetchMovieCreditsUsecase fetchMovieCreditsUsecase,
    required this.movieId,
  }) : _fetchMovieDetailUsecase = fetchMovieDetailUsecase,
       _fetchMovieImagesUsecase = fetchMovieImagesUsecase,
       _fetchMovieCreditsUsecase = fetchMovieCreditsUsecase,
       super(MovieDetailState.initial()) {
    on<FetchMovieDetailEvent>(_fetchMovieDetailEvent);
  }

  Future<void> _fetchMovieDetailEvent(
    FetchMovieDetailEvent event,
    Emitter<MovieDetailState> emit,
  ) async {
    if (state.status == MovieDetailStatus.loading) {
      return;
    }

    emit(state.copyWith(status: MovieDetailStatus.loading));

    try {
      final detailResponse = await _fetchMovieDetailUsecase.fetchMovieDetail(
        movieId: movieId,
        language: AppLanguage.spanish,
      );

      final imagesResponse = await _fetchMovieImagesUsecase.fetchMovieImages(
        movieId: movieId,
      );

      final creditsResponse = await _fetchMovieCreditsUsecase.fetchMovieCredits(
        movieId: movieId,
        language: AppLanguage.spanish,
      );

      await detailResponse.fold(
        (failure) async {
          emit(
            state.copyWith(
              status: MovieDetailStatus.failure,
              errorMessage: failure.message,
            ),
          );
        },
        (movieDetail) async {
          await imagesResponse.fold(
            (failure) async {
              emit(
                state.copyWith(
                  movieDetail: movieDetail,
                  status: MovieDetailStatus.failure,
                  errorMessage: failure.message,
                ),
              );
            },
            (images) async {
              await creditsResponse.fold(
                (failure) async {
                  emit(
                    state.copyWith(
                      movieDetail: movieDetail,
                      images: images,
                      status: MovieDetailStatus.failure,
                      errorMessage: failure.message,
                    ),
                  );
                },
                (casts) async {
                  emit(
                    state.copyWith(
                      movieDetail: movieDetail,
                      images: images,
                      casts: casts,
                      status: MovieDetailStatus.success,
                      errorMessage: null,
                    ),
                  );
                },
              );
            },
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: MovieDetailStatus.failure,
          errorMessage: 'Error inesperado al cargar el detalle',
        ),
      );
    }
  }
}
