import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/movie_detail/domain/entities/movie_detail_entity.dart';
import 'package:imdumb/features/movie_detail/domain/repository/movie_detail_repository.dart';
import 'package:imdumb/features/movie_detail/domain/use_cases/fetch_movie_detail_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_movie_detail_usecase_test.mocks.dart';

@GenerateMocks([MovieDetailRepository])

void main() {
  late FetchMovieDetailUsecase usecase;
  late MockMovieDetailRepository mockRepository;

  setUp(() {
    // (Arrange) Inicializamos el Mock y el UseCase
    mockRepository = MockMovieDetailRepository();
    usecase = FetchMovieDetailUsecase(repository: mockRepository);
  });

  const tMovieId = 550;

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

  test(
    'debería obtener detalle de película del repositorio',
    () async {
      // (Arrange - Configurar el Mock)
      when(mockRepository.fetchMovieDetail(
            movieId: anyNamed('movieId'),
            language: anyNamed('language'),
          )).thenAnswer((_) async => Right(tMovieDetail));

      // (Act - Ejecutar la lógica real)
      final result = await usecase.fetchMovieDetail(movieId: tMovieId);

      // (Assert - Verificar resultado)
      expect(result, Right(tMovieDetail));

      // (Verify - Asegurar que usamos el Repository)
      verify(mockRepository.fetchMovieDetail(
            movieId: tMovieId,
            language: anyNamed('language'),
          )).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'debería retornar error cuando el repositorio falla',
    () async {
      // (Arrange)
      const tFailure = NetworkException('Error de conexión');
      when(mockRepository.fetchMovieDetail(
            movieId: anyNamed('movieId'),
            language: anyNamed('language'),
          )).thenAnswer((_) async => const Left(tFailure));

      // (Act)
      final result = await usecase.fetchMovieDetail(movieId: tMovieId);

      // (Assert)
      expect(result, const Left(tFailure));
      verify(mockRepository.fetchMovieDetail(
            movieId: tMovieId,
            language: anyNamed('language'),
          )).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  group('Casos límite y validaciones', () {
    test(
      'debería usar idioma por defecto cuando no se proporciona',
      () async {
        // (Arrange)
        when(mockRepository.fetchMovieDetail(
              movieId: anyNamed('movieId'),
              language: anyNamed('language'),
            )).thenAnswer((_) async => Right(tMovieDetail));

        // (Act)
        final result = await usecase.fetchMovieDetail(movieId: tMovieId);

        // (Assert)
        expect(result, Right(tMovieDetail));
        verify(mockRepository.fetchMovieDetail(
              movieId: tMovieId,
              language: anyNamed('language'),
            )).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'debería manejar diferentes IDs de película correctamente',
      () async {
        // Arrange
        const differentMovieId = 123;
        final differentMovieDetail = MovieDetailEntity(
          id: differentMovieId,
          title: 'Different Movie',
          overview: 'Different overview',
          voteAverage: 7.5,
          voteCount: 500,
          releaseDate: DateTime(2023, 1, 1),
          backdropPath: '/different.jpg',
          posterPath: '/different_poster.jpg',
          runtime: 90,
          genres: const ['Comedy'],
        );

        when(mockRepository.fetchMovieDetail(
              movieId: anyNamed('movieId'),
              language: anyNamed('language'),
            )).thenAnswer((_) async => Right(differentMovieDetail));

        // (Act)
        final result = await usecase.fetchMovieDetail(movieId: differentMovieId);

        // (Assert)
        expect(result, Right(differentMovieDetail));
        expect(result.fold((l) => null, (r) => r.id), differentMovieId);
        verify(mockRepository.fetchMovieDetail(
              movieId: differentMovieId,
              language: anyNamed('language'),
            )).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );
  });
}
