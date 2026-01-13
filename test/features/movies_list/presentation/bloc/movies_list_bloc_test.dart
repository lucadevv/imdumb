import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/movies_list/domain/entities/movie_list_type.dart';
import 'package:imdumb/features/movies_list/domain/use_cases/fetch_movies_list_usecase.dart';
import 'package:imdumb/features/movies_list/presentation/bloc/movies_list_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockFetchMoviesListUsecase extends Mock
    implements FetchMoviesListUsecase {}

void main() {
  late MoviesListBloc bloc;
  late MockFetchMoviesListUsecase mockUsecase;

  setUpAll(() {
    registerFallbackValue(MovieListType.popular);
  });

  setUp(() {
    mockUsecase = MockFetchMoviesListUsecase();
    bloc = MoviesListBloc(
      fetchMoviesListUsecase: mockUsecase,
      type: MovieListType.popular,
    );
  });

  tearDown(() {
    bloc.close();
  });

  test('estado inicial debe ser MoviesListState.initial()', () {
    expect(bloc.state, MoviesListState.initial());
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

  blocTest<MoviesListBloc, MoviesListState>(
    'debería emitir [loading, success] cuando se obtienen películas exitosamente',
    build: () {
      when(() => mockUsecase.fetchMovies(
            type: any(named: 'type'),
            page: any(named: 'page'),
            language: any(named: 'language'),
            genreId: any(named: 'genreId'),
          )).thenAnswer((_) async => Right(tMovies));
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchMoviesListEvent()),
    expect: () => [
      MoviesListState.initial().copyWith(
        status: MoviesListStatus.loading,
        movies: [],
        page: 1,
        hasMore: true,
      ),
      MoviesListState.initial().copyWith(
        status: MoviesListStatus.success,
        movies: tMovies,
        page: 1,
        hasMore: false,
      ),
    ],
  );

  blocTest<MoviesListBloc, MoviesListState>(
    'debería cargar más películas cuando se hace scroll',
    build: () {
      when(() => mockUsecase.fetchMovies(
            type: any(named: 'type'),
            page: any(named: 'page'),
            language: any(named: 'language'),
            genreId: any(named: 'genreId'),
          )).thenAnswer((_) async => Right(tMovies));
      return bloc;
    },
    seed: () => MoviesListState.initial().copyWith(
      status: MoviesListStatus.success,
      movies: tMovies,
      page: 1,
      hasMore: true,
    ),
    act: (bloc) => bloc.add(
      const FetchMoviesListEvent(isLoadMore: true),
    ),
    expect: () => [
      MoviesListState.initial().copyWith(
        status: MoviesListStatus.loading,
        movies: tMovies,
        page: 1,
        hasMore: true,
      ),
      MoviesListState.initial().copyWith(
        status: MoviesListStatus.success,
        movies: [...tMovies, ...tMovies],
        page: 1,
        hasMore: false,
      ),
    ],
  );

  blocTest<MoviesListBloc, MoviesListState>(
    'debería emitir [loading, failure] cuando falla la obtención',
    build: () {
      const tFailure = NetworkException('Error de conexión');
      when(() => mockUsecase.fetchMovies(
            type: any(named: 'type'),
            page: any(named: 'page'),
            language: any(named: 'language'),
            genreId: any(named: 'genreId'),
          )).thenAnswer((_) async => const Left(tFailure));
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchMoviesListEvent()),
    expect: () => [
      MoviesListState.initial().copyWith(
        status: MoviesListStatus.loading,
        movies: [],
        page: 1,
        hasMore: true,
      ),
      MoviesListState.initial().copyWith(
        status: MoviesListStatus.failure,
        errorMessage: 'Error de conexión',
      ),
    ],
  );
}
