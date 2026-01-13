part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

/// Evento cuando cambia el query de búsqueda (con debounce)
class SearchQueryChangedEvent extends SearchEvent {
  final String query;

  const SearchQueryChangedEvent({required this.query});

  @override
  List<Object> get props => [query];
}

/// Evento para buscar películas
class FetchSearchMoviesEvent extends SearchEvent {
  final String query;
  final int page;
  final bool isLoadMore;

  const FetchSearchMoviesEvent({
    required this.query,
    this.page = 1,
    this.isLoadMore = false,
  });

  @override
  List<Object> get props => [query, page, isLoadMore];
}

/// Evento para limpiar la búsqueda
class ClearSearchEvent extends SearchEvent {
  const ClearSearchEvent();
}
