import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/movie_detail/domain/entities/movie_image_entity.dart';
import 'package:imdumb/features/movie_detail/domain/repository/movie_detail_repository.dart';
import 'package:imdumb/features/movie_detail/domain/use_cases/fetch_movie_images_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_movie_images_usecase_test.mocks.dart';

@GenerateMocks([MovieDetailRepository])

void main() {
  late FetchMovieImagesUsecase usecase;
  late MockMovieDetailRepository mockRepository;

  setUp(() {
    // (Arrange) Inicializamos el Mock y el UseCase
    mockRepository = MockMovieDetailRepository();
    usecase = FetchMovieImagesUsecase(repository: mockRepository);
  });

  const tMovieId = 550;

  final tImages = [
    MovieImageEntity(filePath: '/image1.jpg'),
    MovieImageEntity(filePath: '/image2.jpg'),
  ];

  test('debería obtener imágenes de la película del repositorio', () async {
    // (Arrange - Configurar el Mock)
    when(mockRepository.fetchMovieImages(movieId: anyNamed('movieId')))
        .thenAnswer((_) async => Right(tImages));

    // (Act - Ejecutar la lógica real)
    final result = await usecase.fetchMovieImages(movieId: tMovieId);

    // (Assert - Verificar resultado)
    expect(result, Right(tImages));

    // (Verify - Asegurar que usamos el Repository)
    verify(mockRepository.fetchMovieImages(movieId: tMovieId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('debería retornar error cuando el repositorio falla', () async {
    // (Arrange)
    const tFailure = NetworkException('Error de conexión');
    when(mockRepository.fetchMovieImages(movieId: anyNamed('movieId')))
        .thenAnswer((_) async => const Left(tFailure));

    // (Act)
    final result = await usecase.fetchMovieImages(movieId: tMovieId);

    // (Assert)
    expect(result, const Left(tFailure));
    verify(mockRepository.fetchMovieImages(movieId: tMovieId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('debería manejar lista vacía de imágenes', () async {
    // (Arrange)
    when(mockRepository.fetchMovieImages(movieId: anyNamed('movieId')))
        .thenAnswer((_) async => const Right([]));

    // (Act)
    final result = await usecase.fetchMovieImages(movieId: tMovieId);

    // (Assert)
    expect(result.isRight(), true);
    result.fold(
      (l) => fail('No debería retornar error'),
      (r) => expect(r, isEmpty),
    );
    verify(mockRepository.fetchMovieImages(movieId: tMovieId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
