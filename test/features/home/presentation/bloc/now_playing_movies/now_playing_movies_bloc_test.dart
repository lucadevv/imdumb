import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_now_playing_movie_usecase.dart';
import 'package:imdumb/features/home/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockFetchAllNowPlayingMovieUsecase extends Mock
    implements FetchAllNowPlayingMovieUsecase {}

void main() {
  late NowPlayingMoviesBloc bloc;
  late MockFetchAllNowPlayingMovieUsecase mockUsecase;

  setUp(() {
    mockUsecase = MockFetchAllNowPlayingMovieUsecase();
    bloc = NowPlayingMoviesBloc(
      fetchAllNowPlayingMovieUsecase: mockUsecase,
    );
  });

  tearDown(() {
    bloc.close();
  });

  test('estado inicial debe ser NowPlayingMoviesState.initial()', () {
    expect(bloc.state, NowPlayingMoviesState.initial());
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

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
    'debería emitir [loading, success] cuando se obtienen películas exitosamente',
    build: () {
      when(() => mockUsecase.fetchAllNowPlayingMovies(
            page: any(named: 'page'),
            language: any(named: 'language'),
          )).thenAnswer((_) async => Right(tMovies));
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchNowPlayingMoviesEvent()),
    expect: () => [
      NowPlayingMoviesState.initial().copyWith(
        status: NowPlayingMoviesStatus.loading,
        hasMore: true,
      ),
      NowPlayingMoviesState.initial().copyWith(
        status: NowPlayingMoviesStatus.success,
        movies: tMovies,
        hasMore: false,
      ),
    ],
    verify: (_) {
      verify(() => mockUsecase.fetchAllNowPlayingMovies(
            page: any(named: 'page'),
            language: any(named: 'language'),
          )).called(1);
    },
  );

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
    'debería emitir [loading, failure] cuando falla la obtención',
    build: () {
      const tFailure = NetworkException('Error de conexión');
      when(() => mockUsecase.fetchAllNowPlayingMovies(
            page: any(named: 'page'),
            language: any(named: 'language'),
          )).thenAnswer((_) async => const Left(tFailure));
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchNowPlayingMoviesEvent()),
    expect: () => [
      NowPlayingMoviesState.initial().copyWith(
        status: NowPlayingMoviesStatus.loading,
      ),
      NowPlayingMoviesState.initial().copyWith(
        status: NowPlayingMoviesStatus.failure,
        errorMessage: 'Error de conexión',
      ),
    ],
  );

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
    'no debería hacer nada si ya está en estado loading',
    build: () {
      when(() => mockUsecase.fetchAllNowPlayingMovies(
            page: any(named: 'page'),
            language: any(named: 'language'),
          )).thenAnswer((_) async => Right(tMovies));
      return bloc;
    },
    seed: () => NowPlayingMoviesState.initial().copyWith(
      status: NowPlayingMoviesStatus.loading,
    ),
    act: (bloc) => bloc.add(const FetchNowPlayingMoviesEvent()),
    expect: () => [],
  );
}
