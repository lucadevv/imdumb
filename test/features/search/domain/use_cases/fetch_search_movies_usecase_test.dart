import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/search/domain/repository/search_repository.dart';
import 'package:imdumb/features/search/domain/use_cases/fetch_search_movies_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_search_movies_usecase_test.mocks.dart';

@GenerateMocks([SearchRepository])

void main() {
  late FetchSearchMoviesUsecase usecase;
  late MockSearchRepository mockRepository;

  setUp(() {
    // (Arrange) Inicializamos el Mock y el UseCase
    mockRepository = MockSearchRepository();
    usecase = FetchSearchMoviesUsecase(repository: mockRepository);
  });

  const tQuery = 'test';
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
      voteAverage: 8.0,
      voteCount: 1000,
    ),
  ];

  test(
    'debería obtener películas de búsqueda del repositorio',
    () async {
      // (Arrange - Configurar el Mock)
      when(mockRepository.searchMovies(
            query: anyNamed('query'),
            page: anyNamed('page'),
            language: anyNamed('language'),
          )).thenAnswer((_) async => Right(tMovies));

      // (Act - Ejecutar la lógica real)
      final result = await usecase.execute(
        query: tQuery,
        page: tPage,
        language: tLanguage,
      );

      // (Assert - Verificar resultado)
      expect(result, Right(tMovies));

      // (Verify - Asegurar que usamos el Repository)
      verify(mockRepository.searchMovies(
            query: tQuery,
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
      const tFailure = NetworkException('Error de conexión');
      when(mockRepository.searchMovies(
            query: anyNamed('query'),
            page: anyNamed('page'),
            language: anyNamed('language'),
          )).thenAnswer((_) async => const Left(tFailure));

      // (Act)
      final result = await usecase.execute(
        query: tQuery,
        page: tPage,
        language: tLanguage,
      );

      // (Assert)
      expect(result, const Left(tFailure));
      verify(mockRepository.searchMovies(
            query: tQuery,
            page: tPage,
            language: tLanguage,
          )).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
