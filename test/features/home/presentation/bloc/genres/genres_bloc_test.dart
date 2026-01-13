import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/home/domain/entities/genre_entity.dart';
import 'package:imdumb/features/home/domain/use_cases/fetch_all_genres_usecase.dart';
import 'package:imdumb/features/home/presentation/bloc/genres/genres_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockFetchAllGenresUsecase extends Mock
    implements FetchAllGenresUsecase {}

void main() {
  late GenresBloc bloc;
  late MockFetchAllGenresUsecase mockUsecase;

  setUp(() {
    mockUsecase = MockFetchAllGenresUsecase();
    bloc = GenresBloc(fetchAllGenresUsecase: mockUsecase);
  });

  tearDown(() {
    bloc.close();
  });

  test('estado inicial debe ser GenresState.initial()', () {
    expect(bloc.state, GenresState.initial());
  });

  final tGenres = [
    const GenreEntity(id: 28, name: 'Acción'),
    const GenreEntity(id: 35, name: 'Comedia'),
    const GenreEntity(id: 18, name: 'Drama'),
  ];

  blocTest<GenresBloc, GenresState>(
    'debería emitir [loading, success] cuando se obtienen géneros exitosamente',
    build: () {
      when(() => mockUsecase.fetchAllGenres(
            language: any(named: 'language'),
          )).thenAnswer((_) async => Right(tGenres));
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchGenresEvent()),
    expect: () => [
      GenresState.initial().copyWith(
        status: GenresStatus.loading,
      ),
      GenresState.initial().copyWith(
        status: GenresStatus.success,
        genres: tGenres,
      ),
    ],
    verify: (_) {
      verify(() => mockUsecase.fetchAllGenres(
            language: any(named: 'language'),
          )).called(1);
    },
  );

  blocTest<GenresBloc, GenresState>(
    'debería emitir [loading, failure] cuando falla la obtención',
    build: () {
      const tFailure = NetworkException('Error de conexión');
      when(() => mockUsecase.fetchAllGenres(
            language: any(named: 'language'),
          )).thenAnswer((_) async => const Left(tFailure));
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchGenresEvent()),
    expect: () => [
      GenresState.initial().copyWith(
        status: GenresStatus.loading,
      ),
      GenresState.initial().copyWith(
        status: GenresStatus.failure,
        errorMessage: 'Error de conexión',
      ),
    ],
  );

  blocTest<GenresBloc, GenresState>(
    'debería manejar lista vacía de géneros',
    build: () {
      when(() => mockUsecase.fetchAllGenres(
            language: any(named: 'language'),
          )).thenAnswer((_) async => const Right([]));
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchGenresEvent()),
    expect: () => [
      GenresState.initial().copyWith(
        status: GenresStatus.loading,
      ),
      GenresState.initial().copyWith(
        status: GenresStatus.success,
        genres: [],
      ),
    ],
  );
}
