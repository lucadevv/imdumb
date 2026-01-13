import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_top_rated_movie_usecase.dart';
import 'package:imdumb/features/home/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockFetchAllTopRatedMovieUsecase extends Mock
    implements FetchAllTopRatedMovieUsecase {}

void main() {
  late TopRatedMoviesBloc bloc;
  late MockFetchAllTopRatedMovieUsecase mockUsecase;

  setUp(() {
    mockUsecase = MockFetchAllTopRatedMovieUsecase();
    bloc = TopRatedMoviesBloc(
      fetchAllTopRatedMovieUsecase: mockUsecase,
    );
  });

  tearDown(() {
    bloc.close();
  });

  test('estado inicial debe ser TopRatedMoviesState.initial()', () {
    expect(bloc.state, TopRatedMoviesState.initial());
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
      voteAverage: 9.5,
      voteCount: 5000,
    ),
  ];

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    'debería emitir [loading, success] cuando se obtienen películas exitosamente',
    build: () {
      when(() => mockUsecase.fetchAllTopRatedMovies(
            page: any(named: 'page'),
            language: any(named: 'language'),
          )).thenAnswer((_) async => Right(tMovies));
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchTopRatedMoviesEvent()),
    expect: () => [
      TopRatedMoviesState.initial().copyWith(
        status: TopRatedMoviesStatus.loading,
        hasMore: true,
      ),
      TopRatedMoviesState.initial().copyWith(
        status: TopRatedMoviesStatus.success,
        movies: tMovies,
        hasMore: false,
      ),
    ],
    verify: (_) {
      verify(() => mockUsecase.fetchAllTopRatedMovies(
            page: any(named: 'page'),
            language: any(named: 'language'),
          )).called(1);
    },
  );

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    'debería emitir [loading, failure] cuando falla la obtención',
    build: () {
      const tFailure = ServerException('Error del servidor');
      when(() => mockUsecase.fetchAllTopRatedMovies(
            page: any(named: 'page'),
            language: any(named: 'language'),
          )).thenAnswer((_) async => const Left(tFailure));
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchTopRatedMoviesEvent()),
    expect: () => [
      TopRatedMoviesState.initial().copyWith(
        status: TopRatedMoviesStatus.loading,
      ),
      TopRatedMoviesState.initial().copyWith(
        status: TopRatedMoviesStatus.failure,
        errorMessage: 'Error del servidor',
      ),
    ],
  );
}
