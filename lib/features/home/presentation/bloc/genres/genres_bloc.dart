import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:imdumb/core/utils/constans/app_language.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/domain/entities/genre_entity.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_genres_usecase.dart';

part 'genres_event.dart';
part 'genres_state.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState> {
  final FetchAllGenresUsecase _fetchAllGenresUsecase;

  GenresBloc({
    required FetchAllGenresUsecase fetchAllGenresUsecase,
  })  : _fetchAllGenresUsecase = fetchAllGenresUsecase,
        super(GenresState.initial()) {
    on<FetchGenresEvent>(_fetchGenresEvent);
  }

  Future<void> _fetchGenresEvent(
    FetchGenresEvent event,
    Emitter<GenresState> emit,
  ) async {
    if (state.status == GenresStatus.loading) {
      return;
    }

    emit(state.copyWith(status: GenresStatus.loading));

    final response = await _fetchAllGenresUsecase.fetchAllGenres(
      language: AppLanguage.spanish,
    );

    await response.fold(
      (failure) async {
        String errorMessage = _getErrorMessage(failure);
        emit(
          state.copyWith(
            status: GenresStatus.failure,
            errorMessage: errorMessage,
          ),
        );
      },
      (genres) async {
        emit(
          state.copyWith(
            genres: genres,
            status: GenresStatus.success,
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
