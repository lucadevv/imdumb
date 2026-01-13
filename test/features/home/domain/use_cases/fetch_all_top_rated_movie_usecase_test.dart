import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/home/domain/repository/home_repository.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_top_rated_movie_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_all_top_rated_movie_usecase_test.mocks.dart';

@GenerateMocks([HomeRepository])

void main() {
  late FetchAllTopRatedMovieUsecase usecase;
  late MockHomeRepository mockRepository;

  setUp(() {
    // (Arrange) Inicializamos el Mock y el UseCase
    mockRepository = MockHomeRepository();
    usecase = FetchAllTopRatedMovieUsecase(repository: mockRepository);
  });

  const tPage = '1';
  const tLanguage = 'es-ES';

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

  test(
    'debería obtener películas mejor valoradas del repositorio',
    () async {
      // (Arrange - Configurar el Mock)
      when(mockRepository.fetchAllTopRatedMovies(
            page: anyNamed('page'),
            language: anyNamed('language'),
          )).thenAnswer((_) async => Right(tMovies));

      // (Act - Ejecutar la lógica real)
      final result = await usecase.fetchAllTopRatedMovies(
        page: tPage,
        language: tLanguage,
      );

      // (Assert - Verificar resultado)
      expect(result, Right(tMovies));

      // (Verify - Asegurar que usamos el Repository)
      verify(mockRepository.fetchAllTopRatedMovies(
            page: tPage,
            language: tLanguage,
          )).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'debería retornar error cuando el repositorio falla',
    () async {
      // (Arrange)
      const tFailure = ServerException('Error del servidor');
      when(mockRepository.fetchAllTopRatedMovies(
            page: anyNamed('page'),
            language: anyNamed('language'),
          )).thenAnswer((_) async => const Left(tFailure));

      // (Act)
      final result = await usecase.fetchAllTopRatedMovies(
        page: tPage,
        language: tLanguage,
      );

      // (Assert)
      expect(result, const Left(tFailure));
      verify(mockRepository.fetchAllTopRatedMovies(
            page: tPage,
            language: tLanguage,
          )).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'debería manejar lista vacía correctamente',
    () async {
      // (Arrange)
      when(mockRepository.fetchAllTopRatedMovies(
            page: anyNamed('page'),
            language: anyNamed('language'),
          )).thenAnswer((_) async => const Right([]));

      // (Act)
      final result = await usecase.fetchAllTopRatedMovies();

      // (Assert)
      expect(result.isRight(), true);
      result.fold(
        (l) => fail('No debería retornar error'),
        (r) => expect(r, isEmpty),
      );
      verify(mockRepository.fetchAllTopRatedMovies(
            page: anyNamed('page'),
            language: anyNamed('language'),
          )).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
