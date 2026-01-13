import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/search/domain/use_cases/fetch_search_movies_usecase.dart';
import 'package:imdumb/features/search/presentation/bloc/search_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockFetchSearchMoviesUsecase extends Mock
    implements FetchSearchMoviesUsecase {}

void main() {
  late SearchBloc bloc;
  late MockFetchSearchMoviesUsecase mockUsecase;

  setUp(() {
    mockUsecase = MockFetchSearchMoviesUsecase();
    bloc = SearchBloc(fetchSearchMoviesUsecase: mockUsecase);
  });

  tearDown(() {
    bloc.close();
  });

  test('estado inicial debe ser SearchState.initial()', () {
    expect(bloc.state, SearchState.initial());
  });

  final tMovies = [
    PopularMovieEntity(
      adult: false,
      backdropPath: '/test.jpg',
      id: 1,
      originalLanguage: 'en',
      originalTitle: 'Test Movie',
      overview: 'Test overview',
      popularity: 100.0,
      posterPath: '/poster.jpg',
      releaseDate: DateTime(2024, 1, 1),
      title: 'Test Movie',
      video: false,
      voteAverage: 8.0,
      voteCount: 1000,
    ),
  ];

  blocTest<SearchBloc, SearchState>(
    'debería buscar películas cuando se ejecuta FetchSearchMoviesEvent',
    build: () {
      when(
        () => mockUsecase.execute(
          query: any(named: 'query'),
          page: any(named: 'page'),
          language: any(named: 'language'),
        ),
      ).thenAnswer((_) async => Right(tMovies));
      return bloc;
    },
    act: (bloc) =>
        bloc.add(const FetchSearchMoviesEvent(query: 'test', page: 1)),
    expect: () => [
      SearchState.initial().copyWith(
        status: SearchStatus.loading,
        movies: [],
        page: 1,
        hasMore: true,
        query: '',
      ),
      SearchState.initial().copyWith(
        status: SearchStatus.success,
        movies: tMovies,
        page: 1,
        hasMore:
            false, // hasMore será false porque tMovies tiene solo 1 elemento (< 20)
        query: '',
      ),
    ],
  );

  blocTest<SearchBloc, SearchState>(
    'debería limpiar la búsqueda cuando se llama ClearSearchEvent',
    build: () => bloc,
    act: (bloc) => bloc.add(const ClearSearchEvent()),
    expect: () => [SearchState.initial()],
  );
}
