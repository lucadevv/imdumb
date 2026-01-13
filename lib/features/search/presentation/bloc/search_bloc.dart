import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:imdumb/core/bloc/base_bloc_mixin.dart';
import 'package:imdumb/core/utils/constans/app_language.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/search/domain/use_cases/fetch_search_movies_usecase.dart';

part 'search_event.dart';
part 'search_state.dart';

/// SOLID: Single Responsibility Principle (SRP)
///
/// Este bloc tiene una única responsabilidad: gestionar el estado
/// de la búsqueda de películas. No maneja UI directamente, solo
/// coordina la lógica de búsqueda y el estado de la aplicación.
///
/// Patrón aplicado: BLoC Pattern
/// Separa la lógica de negocio de la UI, facilitando el testing
/// y el mantenimiento.
class SearchBloc extends Bloc<SearchEvent, SearchState> with BaseBlocMixin {
  final FetchSearchMoviesUsecase _fetchSearchMoviesUsecase;
  Timer? _debounceTimer;

  SearchBloc({
    required FetchSearchMoviesUsecase fetchSearchMoviesUsecase,
  })  : _fetchSearchMoviesUsecase = fetchSearchMoviesUsecase,
        super(SearchState.initial()) {
    on<SearchQueryChangedEvent>(_onSearchQueryChangedEvent);
    on<FetchSearchMoviesEvent>(_onFetchSearchMoviesEvent);
    on<ClearSearchEvent>(_onClearSearchEvent);
  }

  /// Maneja el cambio de query con debounce
  Future<void> _onSearchQueryChangedEvent(
    SearchQueryChangedEvent event,
    Emitter<SearchState> emit,
  ) async {
    // Cancelar timer anterior si existe
    _debounceTimer?.cancel();

    // Si el query está vacío, limpiar resultados
    if (event.query.isEmpty || event.query.trim().isEmpty) {
      emit(state.copyWith(
        query: '',
        movies: [],
        status: SearchStatus.initial,
        page: 1,
        hasMore: false,
      ));
      return;
    }

    // Actualizar query en el estado
    emit(state.copyWith(query: event.query));

    // Crear nuevo timer con debounce de 500ms
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      // Después del debounce, disparar la búsqueda
      add(FetchSearchMoviesEvent(query: event.query, page: 1));
    });
  }

  /// Maneja la búsqueda de películas
  Future<void> _onFetchSearchMoviesEvent(
    FetchSearchMoviesEvent event,
    Emitter<SearchState> emit,
  ) async {
    if (state.status == SearchStatus.loading && !event.isLoadMore) {
      return;
    }

    if (!event.isLoadMore) {
      emit(
        state.copyWith(
          status: SearchStatus.loading,
          movies: [],
          page: 1,
          hasMore: true,
        ),
      );
    } else {
      emit(state.copyWith(status: SearchStatus.loading));
    }

    final response = await _fetchSearchMoviesUsecase.execute(
      query: event.query,
      page: event.page.toString(),
      language: AppLanguage.spanish,
    );

    await response.fold(
      (failure) async {
        String errorMessage = getErrorMessage(failure);
        emit(
          state.copyWith(
            status: SearchStatus.failure,
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
            status: SearchStatus.success,
            page: event.page,
            hasMore: hasMore,
            errorMessage: null,
          ),
        );
      },
    );
  }

  /// Maneja la limpieza de búsqueda
  void _onClearSearchEvent(
    ClearSearchEvent event,
    Emitter<SearchState> emit,
  ) {
    _debounceTimer?.cancel();
    emit(SearchState.initial());
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
