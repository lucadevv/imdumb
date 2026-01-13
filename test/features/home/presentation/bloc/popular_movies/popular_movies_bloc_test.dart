import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_popular_movie_usecase.dart';
import 'package:imdumb/features/home/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:mocktail/mocktail.dart';

/// SOLID: Single Responsibility Principle (SRP)
///
/// Esta clase mock tiene una única responsabilidad: simular el comportamiento
/// de FetchAllPopularMovieUsecase para las pruebas unitarias del bloc.
///
/// Patrón aplicado: Mock Object Pattern
class MockFetchAllPopularMovieUsecase extends Mock
    implements FetchAllPopularMovieUsecase {}

void main() {
  late PopularMoviesBloc bloc;
  late MockFetchAllPopularMovieUsecase mockUsecase;

  setUp(() {
    mockUsecase = MockFetchAllPopularMovieUsecase();
    bloc = PopularMoviesBloc(fetchAllPopularMovieUsecase: mockUsecase);
  });

  tearDown(() {
    bloc.close();
  });

  test('estado inicial debe ser PopularMoviesState.initial()', () {
    expect(bloc.state, PopularMoviesState.initial());
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

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'debería emitir [loading, success] cuando se obtienen películas exitosamente',
    build: () {
      when(() => mockUsecase.fetchAllPopularMovies(
            page: any(named: 'page'),
            language: any(named: 'language'),
          )).thenAnswer((_) async => Right(tMovies));
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchPopularMoviesEvent()),
    expect: () => [
      PopularMoviesState.initial().copyWith(
        status: PopularMoviesStatus.loading,
      ),
      PopularMoviesState.initial().copyWith(
        status: PopularMoviesStatus.success,
        movies: tMovies,
      ),
    ],
    verify: (_) {
      verify(() => mockUsecase.fetchAllPopularMovies(
            page: any(named: 'page'),
            language: any(named: 'language'),
          )).called(1);
    },
  );

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'debería emitir [loading, failure] cuando falla la obtención de películas',
    build: () {
      const tFailure = NetworkException('Error de conexión');
      when(() => mockUsecase.fetchAllPopularMovies(
            page: any(named: 'page'),
            language: any(named: 'language'),
          )).thenAnswer((_) async => const Left(tFailure));
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchPopularMoviesEvent()),
    expect: () => [
      PopularMoviesState.initial().copyWith(
        status: PopularMoviesStatus.loading,
      ),
      PopularMoviesState.initial().copyWith(
        status: PopularMoviesStatus.failure,
        errorMessage: 'Error de conexión',
      ),
    ],
    verify: (_) {
      verify(() => mockUsecase.fetchAllPopularMovies(
            page: any(named: 'page'),
            language: any(named: 'language'),
          )).called(1);
    },
  );
}
