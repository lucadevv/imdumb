import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/domain/entities/genre_entity.dart';
import 'package:imdumb/features/home/domain/repository/home_repository.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_genres_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_all_genres_usecase_test.mocks.dart';

@GenerateMocks([HomeRepository])

void main() {
  late FetchAllGenresUsecase usecase;
  late MockHomeRepository mockRepository;

  setUp(() {
    // (Arrange) Inicializamos el Mock y el UseCase
    mockRepository = MockHomeRepository();
    usecase = FetchAllGenresUsecase(repository: mockRepository);
  });

  const tLanguage = 'es-ES';

  final tGenres = [
    const GenreEntity(id: 28, name: 'Acción'),
    const GenreEntity(id: 35, name: 'Comedia'),
    const GenreEntity(id: 18, name: 'Drama'),
  ];

  test(
    'debería obtener lista de géneros del repositorio',
    () async {
      // (Arrange - Configurar el Mock)
      when(mockRepository.fetchAllGenres(language: anyNamed('language')))
          .thenAnswer((_) async => Right(tGenres));

      // (Act - Ejecutar la lógica real)
      final result = await usecase.fetchAllGenres(language: tLanguage);

      // (Assert - Verificar resultado)
      expect(result, Right(tGenres));

      // (Verify - Asegurar que usamos el Repository)
      verify(mockRepository.fetchAllGenres(language: tLanguage)).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'debería retornar error cuando el repositorio falla',
    () async {
      // (Arrange)
      const tFailure = NetworkException('Error de conexión');
      when(mockRepository.fetchAllGenres(language: anyNamed('language')))
          .thenAnswer((_) async => const Left(tFailure));

      // (Act)
      final result = await usecase.fetchAllGenres(language: tLanguage);

      // (Assert)
      expect(result, const Left(tFailure));
      verify(mockRepository.fetchAllGenres(language: tLanguage)).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'debería usar idioma por defecto cuando no se proporciona',
    () async {
      // (Arrange)
      when(mockRepository.fetchAllGenres(language: anyNamed('language')))
          .thenAnswer((_) async => Right(tGenres));

      // (Act)
      final result = await usecase.fetchAllGenres();

      // (Assert)
      expect(result, Right(tGenres));
      verify(mockRepository.fetchAllGenres(language: anyNamed('language')))
          .called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'debería manejar lista vacía de géneros',
    () async {
      // (Arrange)
      when(mockRepository.fetchAllGenres(language: anyNamed('language')))
          .thenAnswer((_) async => const Right([]));

      // (Act)
      final result = await usecase.fetchAllGenres();

      // (Assert)
      expect(result.isRight(), true);
      result.fold(
        (l) => fail('No debería retornar error'),
        (r) => expect(r, isEmpty),
      );
      verify(mockRepository.fetchAllGenres(language: anyNamed('language')))
          .called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
