import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/movie_detail/domain/entities/cast_entity.dart';
import 'package:imdumb/features/movie_detail/domain/entities/movie_detail_entity.dart';
import 'package:imdumb/features/movie_detail/domain/entities/movie_image_entity.dart';
import 'package:imdumb/features/movie_detail/domain/use_cases/fetch_movie_credits_usecase.dart';
import 'package:imdumb/features/movie_detail/domain/use_cases/fetch_movie_detail_usecase.dart';
import 'package:imdumb/features/movie_detail/domain/use_cases/fetch_movie_images_usecase.dart';
import 'package:imdumb/features/movie_detail/presentation/bloc/movie_detail_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockFetchMovieDetailUsecase extends Mock
    implements FetchMovieDetailUsecase {}

class MockFetchMovieImagesUsecase extends Mock
    implements FetchMovieImagesUsecase {}

class MockFetchMovieCreditsUsecase extends Mock
    implements FetchMovieCreditsUsecase {}

void main() {
  late MovieDetailBloc bloc;
  late MockFetchMovieDetailUsecase mockDetailUsecase;
  late MockFetchMovieImagesUsecase mockImagesUsecase;
  late MockFetchMovieCreditsUsecase mockCreditsUsecase;

  const tMovieId = 550;

  setUpAll(() {
    // Registrar fallback values para mocktail
    registerFallbackValue(
      MovieDetailEntity(
        id: 0,
        title: 'Fallback Title',
        overview: 'Fallback Overview',
        voteAverage: 0.0,
        voteCount: 0,
      ),
    );
    registerFallbackValue(const MovieImageEntity());
    registerFallbackValue(
      const CastEntity(
        id: 0,
        name: 'Fallback Actor',
      ),
    );
  });

  setUp(() {
    mockDetailUsecase = MockFetchMovieDetailUsecase();
    mockImagesUsecase = MockFetchMovieImagesUsecase();
    mockCreditsUsecase = MockFetchMovieCreditsUsecase();

    bloc = MovieDetailBloc(
      fetchMovieDetailUsecase: mockDetailUsecase,
      fetchMovieImagesUsecase: mockImagesUsecase,
      fetchMovieCreditsUsecase: mockCreditsUsecase,
      movieId: tMovieId,
    );
  });

  tearDown(() {
    bloc.close();
  });

  test('estado inicial debe ser MovieDetailState.initial()', () {
    expect(bloc.state, MovieDetailState.initial());
    expect(bloc.state.status, MovieDetailStatus.initial);
  });

  test('bloc debe tener el movieId correcto', () {
    expect(bloc.movieId, tMovieId);
  });

  final tMovieDetail = MovieDetailEntity(
    id: tMovieId,
    title: 'Test Movie',
    overview: 'Test overview',
    voteAverage: 8.0,
    voteCount: 1000,
    releaseDate: DateTime(2024, 1, 1),
    backdropPath: '/test.jpg',
    posterPath: '/poster.jpg',
    runtime: 120,
    genres: const ['Action', 'Drama'],
  );

  final tImages = const [
    MovieImageEntity(
      filePath: '/image1.jpg',
    ),
    MovieImageEntity(
      filePath: '/image2.jpg',
    ),
  ];

  final tCast = const [
    CastEntity(
      id: 1,
      name: 'Test Actor',
      character: 'Test Character',
      profilePath: '/profile.jpg',
    ),
    CastEntity(
      id: 2,
      name: 'Another Actor',
      character: 'Another Character',
      profilePath: '/profile2.jpg',
    ),
  ];

  blocTest<MovieDetailBloc, MovieDetailState>(
    'debería cargar detalle, imágenes y créditos cuando se ejecuta FetchMovieDetailEvent',
    build: () {
      when(() => mockDetailUsecase.fetchMovieDetail(
            movieId: any(named: 'movieId'),
            language: any(named: 'language'),
          )).thenAnswer((_) async => Right(tMovieDetail));

      when(() => mockImagesUsecase.fetchMovieImages(
            movieId: any(named: 'movieId'),
          )).thenAnswer((_) async => Right(tImages));

      when(() => mockCreditsUsecase.fetchMovieCredits(
            movieId: any(named: 'movieId'),
            language: any(named: 'language'),
          )).thenAnswer((_) async => Right(tCast));

      return bloc;
    },
    act: (bloc) => bloc.add(const FetchMovieDetailEvent()),
    expect: () => [
      MovieDetailState.initial().copyWith(
        status: MovieDetailStatus.loading,
      ),
      MovieDetailState.initial().copyWith(
        status: MovieDetailStatus.success,
        movieDetail: tMovieDetail,
        images: tImages,
        casts: tCast,
      ),
    ],
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'debería emitir failure cuando falla la obtención del detalle',
    build: () {
      const tFailure = NetworkException('Error de conexión');
      when(() => mockDetailUsecase.fetchMovieDetail(
            movieId: any(named: 'movieId'),
            language: any(named: 'language'),
          )).thenAnswer((_) async => const Left(tFailure));

      // No deberían ser llamados, pero los configuramos para evitar errores
      when(() => mockImagesUsecase.fetchMovieImages(
            movieId: any(named: 'movieId'),
          )).thenAnswer((_) async => const Right([]));

      when(() => mockCreditsUsecase.fetchMovieCredits(
            movieId: any(named: 'movieId'),
            language: any(named: 'language'),
          )).thenAnswer((_) async => const Right([]));

      return bloc;
    },
    act: (bloc) => bloc.add(const FetchMovieDetailEvent()),
    expect: () => [
      MovieDetailState.initial().copyWith(
        status: MovieDetailStatus.loading,
      ),
      MovieDetailState.initial().copyWith(
        status: MovieDetailStatus.failure,
        errorMessage: 'Error de conexión',
      ),
    ],
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'debería emitir failure cuando falla la obtención de imágenes',
    build: () {
      const tFailure = NetworkException('Error al cargar imágenes');
      when(() => mockDetailUsecase.fetchMovieDetail(
            movieId: any(named: 'movieId'),
            language: any(named: 'language'),
          )).thenAnswer((_) async => Right(tMovieDetail));

      when(() => mockImagesUsecase.fetchMovieImages(
            movieId: any(named: 'movieId'),
          )).thenAnswer((_) async => const Left(tFailure));

      // También mockear créditos para evitar que lance excepción
      when(() => mockCreditsUsecase.fetchMovieCredits(
            movieId: any(named: 'movieId'),
            language: any(named: 'language'),
          )).thenAnswer((_) async => const Right([]));

      return bloc;
    },
    act: (bloc) => bloc.add(const FetchMovieDetailEvent()),
    expect: () => [
      MovieDetailState.initial().copyWith(
        status: MovieDetailStatus.loading,
      ),
      MovieDetailState.initial().copyWith(
        movieDetail: tMovieDetail,
        status: MovieDetailStatus.failure,
        errorMessage: 'Error al cargar imágenes',
      ),
    ],
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'debería emitir failure cuando falla la obtención de créditos',
    build: () {
      const tFailure = NetworkException('Error al cargar elenco');
      when(() => mockDetailUsecase.fetchMovieDetail(
            movieId: any(named: 'movieId'),
            language: any(named: 'language'),
          )).thenAnswer((_) async => Right(tMovieDetail));

      when(() => mockImagesUsecase.fetchMovieImages(
            movieId: any(named: 'movieId'),
          )).thenAnswer((_) async => Right(tImages));

      when(() => mockCreditsUsecase.fetchMovieCredits(
            movieId: any(named: 'movieId'),
            language: any(named: 'language'),
          )).thenAnswer((_) async => const Left(tFailure));

      return bloc;
    },
    act: (bloc) => bloc.add(const FetchMovieDetailEvent()),
    expect: () => [
      MovieDetailState.initial().copyWith(
        status: MovieDetailStatus.loading,
      ),
      MovieDetailState.initial().copyWith(
        movieDetail: tMovieDetail,
        images: tImages,
        status: MovieDetailStatus.failure,
        errorMessage: 'Error al cargar elenco',
      ),
    ],
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'no debería hacer nada si ya está en estado loading',
    build: () {
      when(() => mockDetailUsecase.fetchMovieDetail(
            movieId: any(named: 'movieId'),
            language: any(named: 'language'),
          )).thenAnswer((_) async => Right(tMovieDetail));

      return bloc;
    },
    seed: () => MovieDetailState.initial().copyWith(
      status: MovieDetailStatus.loading,
    ),
    act: (bloc) => bloc.add(const FetchMovieDetailEvent()),
    expect: () => [],
  );
}
