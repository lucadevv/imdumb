import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/movie_detail/domain/entities/cast_entity.dart';
import 'package:imdumb/features/movie_detail/domain/repository/movie_detail_repository.dart';
import 'package:imdumb/features/movie_detail/domain/use_cases/fetch_movie_credits_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_movie_credits_usecase_test.mocks.dart';

@GenerateMocks([MovieDetailRepository])

void main() {
  late FetchMovieCreditsUsecase usecase;
  late MockMovieDetailRepository mockRepository;

  setUp(() {
    // (Arrange) Inicializamos el Mock y el UseCase
    mockRepository = MockMovieDetailRepository();
    usecase = FetchMovieCreditsUsecase(repository: mockRepository);
  });

  const tMovieId = 550;
  const tLanguage = 'es-ES';

  final tCast = [
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

  test('debería obtener elenco de la película del repositorio', () async {
    // (Arrange - Configurar el Mock)
    when(mockRepository.fetchMovieCredits(
          movieId: anyNamed('movieId'),
          language: anyNamed('language'),
        )).thenAnswer((_) async => Right(tCast));

    // (Act - Ejecutar la lógica real)
    final result = await usecase.fetchMovieCredits(
      movieId: tMovieId,
      language: tLanguage,
    );

    // (Assert - Verificar resultado)
    expect(result, Right(tCast));

    // (Verify - Asegurar que usamos el Repository)
    verify(mockRepository.fetchMovieCredits(
          movieId: tMovieId,
          language: tLanguage,
        )).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('debería retornar error cuando el repositorio falla', () async {
    // (Arrange)
    const tFailure = NetworkException('Error de conexión');
    when(mockRepository.fetchMovieCredits(
          movieId: anyNamed('movieId'),
          language: anyNamed('language'),
        )).thenAnswer((_) async => const Left(tFailure));

    // (Act)
    final result = await usecase.fetchMovieCredits(movieId: tMovieId);

    // (Assert)
    expect(result, const Left(tFailure));
    verify(mockRepository.fetchMovieCredits(
          movieId: tMovieId,
          language: anyNamed('language'),
        )).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('debería usar idioma por defecto cuando no se proporciona', () async {
    // (Arrange)
    when(mockRepository.fetchMovieCredits(
          movieId: anyNamed('movieId'),
          language: anyNamed('language'),
        )).thenAnswer((_) async => Right(tCast));

    // (Act)
    final result = await usecase.fetchMovieCredits(movieId: tMovieId);

    // (Assert)
    expect(result, Right(tCast));
    verify(mockRepository.fetchMovieCredits(
          movieId: tMovieId,
          language: anyNamed('language'),
        )).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('debería manejar lista vacía de elenco', () async {
    // (Arrange)
    when(mockRepository.fetchMovieCredits(
          movieId: anyNamed('movieId'),
          language: anyNamed('language'),
        )).thenAnswer((_) async => const Right([]));

    // (Act)
    final result = await usecase.fetchMovieCredits(movieId: tMovieId);

    // (Assert)
    expect(result.isRight(), true);
    result.fold(
      (l) => fail('No debería retornar error'),
      (r) => expect(r, isEmpty),
    );
    verify(mockRepository.fetchMovieCredits(
          movieId: tMovieId,
          language: anyNamed('language'),
        )).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
