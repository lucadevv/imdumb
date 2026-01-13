import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';
import 'package:imdumb/features/movies_list/domain/entities/movie_list_type.dart';
import 'package:imdumb/features/movies_list/domain/repository/movies_list_repository.dart';
import 'package:imdumb/features/movies_list/domain/use_cases/fetch_movies_list_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_movies_list_usecase_test.mocks.dart';

@GenerateMocks([MoviesListRepository])

void main() {
  late FetchMoviesListUsecase usecase;
  late MockMoviesListRepository mockRepository;

  setUp(() {
    // (Arrange) Inicializamos el Mock y el UseCase
    mockRepository = MockMoviesListRepository();
    usecase = FetchMoviesListUsecase(repository: mockRepository);
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

  test(
    'debería obtener películas del repositorio',
    () async {
      // (Arrange - Configurar el Mock)
      when(mockRepository.fetchMovies(
            type: anyNamed('type'),
            page: anyNamed('page'),
            language: anyNamed('language'),
            genreId: anyNamed('genreId'),
          )).thenAnswer((_) async => Right(tMovies));

      // (Act - Ejecutar la lógica real)
      final result = await usecase.fetchMovies(
        type: MovieListType.popular,
        page: '1',
      );

      // (Assert - Verificar resultado)
      expect(result, Right(tMovies));

      // (Verify - Asegurar que usamos el Repository)
      verify(mockRepository.fetchMovies(
            type: MovieListType.popular,
            page: '1',
            language: anyNamed('language'),
            genreId: anyNamed('genreId'),
          )).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'debería retornar error cuando el repositorio falla',
    () async {
      // (Arrange)
      const tFailure = NetworkException('Error de conexión');
      when(mockRepository.fetchMovies(
            type: anyNamed('type'),
            page: anyNamed('page'),
            language: anyNamed('language'),
            genreId: anyNamed('genreId'),
          )).thenAnswer((_) async => const Left(tFailure));

      // (Act)
      final result = await usecase.fetchMovies(
        type: MovieListType.popular,
        page: '1',
      );

      // (Assert)
      expect(result, const Left(tFailure));
      verify(mockRepository.fetchMovies(
            type: MovieListType.popular,
            page: '1',
            language: anyNamed('language'),
            genreId: anyNamed('genreId'),
          )).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
