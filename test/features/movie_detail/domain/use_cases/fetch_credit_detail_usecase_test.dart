import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/movie_detail/domain/entities/credit_detail_entity.dart';
import 'package:imdumb/features/movie_detail/domain/repository/movie_detail_repository.dart';
import 'package:imdumb/features/movie_detail/domain/use_cases/fetch_credit_detail_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_credit_detail_usecase_test.mocks.dart';

@GenerateMocks([MovieDetailRepository])

void main() {
  late FetchCreditDetailUsecase usecase;
  late MockMovieDetailRepository mockRepository;

  setUp(() {
    // (Arrange) Inicializamos el Mock y el UseCase
    mockRepository = MockMovieDetailRepository();
    usecase = FetchCreditDetailUsecase(repository: mockRepository);
  });

  const tCreditId = '52fe4751c3a36847f8024f95';
  const tLanguage = 'es-ES';

  final tCreditDetail = CreditDetailEntity(
    id: tCreditId,
    creditType: 'cast',
    department: 'Acting',
    job: 'Actor',
    mediaType: 'movie',
  );

  test(
    'debería obtener detalle de crédito del repositorio',
    () async {
      // (Arrange - Configurar el Mock)
      when(mockRepository.fetchCreditDetail(
            creditId: anyNamed('creditId'),
            language: anyNamed('language'),
          )).thenAnswer((_) async => Right(tCreditDetail));

      // (Act - Ejecutar la lógica real)
      final result = await usecase.fetchCreditDetail(
        creditId: tCreditId,
        language: tLanguage,
      );

      // (Assert - Verificar resultado)
      expect(result, Right(tCreditDetail));

      // (Verify - Asegurar que usamos el Repository)
      verify(mockRepository.fetchCreditDetail(
            creditId: tCreditId,
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
      when(mockRepository.fetchCreditDetail(
            creditId: anyNamed('creditId'),
            language: anyNamed('language'),
          )).thenAnswer((_) async => const Left(tFailure));

      // (Act)
      final result = await usecase.fetchCreditDetail(
        creditId: tCreditId,
        language: tLanguage,
      );

      // (Assert)
      expect(result, const Left(tFailure));
      verify(mockRepository.fetchCreditDetail(
            creditId: tCreditId,
            language: tLanguage,
          )).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'debería usar idioma por defecto cuando no se proporciona',
    () async {
      // (Arrange)
      when(mockRepository.fetchCreditDetail(
            creditId: anyNamed('creditId'),
            language: anyNamed('language'),
          )).thenAnswer((_) async => Right(tCreditDetail));

      // (Act)
      final result = await usecase.fetchCreditDetail(creditId: tCreditId);

      // (Assert)
      expect(result, Right(tCreditDetail));
      verify(mockRepository.fetchCreditDetail(
            creditId: tCreditId,
            language: anyNamed('language'),
          )).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
