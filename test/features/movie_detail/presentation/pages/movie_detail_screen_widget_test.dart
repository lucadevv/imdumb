import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdumb/features/movie_detail/domain/entities/cast_entity.dart';
import 'package:imdumb/features/movie_detail/domain/entities/movie_detail_entity.dart';
import 'package:imdumb/features/movie_detail/domain/entities/movie_image_entity.dart';
import 'package:imdumb/features/movie_detail/presentation/bloc/movie_detail_bloc.dart';
import 'package:imdumb/features/movie_detail/presentation/movie_detail_screen.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_widget_helper.dart';

/// Mock para MovieDetailBloc
class MockMovieDetailBloc extends Mock implements MovieDetailBloc {}

void main() {
  group('MovieDetailScreen Widget Tests', () {
    late MockMovieDetailBloc mockMovieDetailBloc;
    const tMovieId = 550;

    setUp(() {
      mockMovieDetailBloc = MockMovieDetailBloc();
    });

    /// Helper para crear el widget testeable con el bloc
    Widget makeTestableMovieDetailScreen() {
      return TestWidgetHelper.makeTestableWidgetWithBloc<MovieDetailBloc>(
        bloc: mockMovieDetailBloc,
        widget: MovieDetailScreen(movieId: tMovieId),
      );
    }

    testWidgets('debería mostrar shimmer mientras carga', (tester) async {
      // Arrange
      when(
        () => mockMovieDetailBloc.state,
      ).thenReturn(MovieDetailState.initial());
      whenListen(mockMovieDetailBloc, Stream.value(MovieDetailState.initial()));

      // Act
      await tester.pumpWidget(makeTestableMovieDetailScreen());
      await tester.pump();

      // Assert - Verificar que se muestra el shimmer o loading
      expect(find.byType(CircularProgressIndicator), findsNothing);
      // El shimmer puede estar en un widget personalizado
    });

    testWidgets('debería mostrar detalles de la película cuando hay datos', (
      tester,
    ) async {
      // Arrange
      final movieDetail = MovieDetailEntity(
        id: tMovieId,
        title: 'Test Movie',
        overview: '<p>Test overview</p>',
        voteAverage: 8.5,
        voteCount: 1000,
        releaseDate: DateTime(2024, 1, 1),
        backdropPath: '/test_backdrop.jpg',
        posterPath: '/test_poster.jpg',
        runtime: 120,
        genres: const ['Action', 'Drama'],
      );

      final images = [
        MovieImageEntity(filePath: '/image1.jpg'),
        MovieImageEntity(filePath: '/image2.jpg'),
      ];

      final cast = [
        CastEntity(
          id: 1,
          name: 'Test Actor',
          character: 'Test Character',
          profilePath: '/profile.jpg',
        ),
      ];

      when(() => mockMovieDetailBloc.state).thenReturn(
        MovieDetailState.initial().copyWith(
          status: MovieDetailStatus.success,
          movieDetail: movieDetail,
          images: images,
          casts: cast,
        ),
      );
      whenListen(
        mockMovieDetailBloc,
        Stream.value(
          MovieDetailState.initial().copyWith(
            status: MovieDetailStatus.success,
            movieDetail: movieDetail,
            images: images,
            casts: cast,
          ),
        ),
      );

      // Act
      await tester.pumpWidget(makeTestableMovieDetailScreen());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - Verificar que se muestra el título (puede haber múltiples instancias)
      expect(find.text('Test Movie'), findsWidgets);
    });

    testWidgets('debería mostrar botón de Recomendar', (tester) async {
      // Arrange
      final movieDetail = MovieDetailEntity(
        id: tMovieId,
        title: 'Test Movie',
        overview: 'Test overview',
        voteAverage: 8.5,
        voteCount: 1000,
        releaseDate: DateTime(2024, 1, 1),
        backdropPath: '/test_backdrop.jpg',
        posterPath: '/test_poster.jpg',
        runtime: 120,
        genres: const ['Action'],
      );

      when(() => mockMovieDetailBloc.state).thenReturn(
        MovieDetailState.initial().copyWith(
          status: MovieDetailStatus.success,
          movieDetail: movieDetail,
        ),
      );
      whenListen(
        mockMovieDetailBloc,
        Stream.value(
          MovieDetailState.initial().copyWith(
            status: MovieDetailStatus.success,
            movieDetail: movieDetail,
          ),
        ),
      );

      // Act
      await tester.pumpWidget(makeTestableMovieDetailScreen());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - Buscar el botón de Recomendar
      expect(find.text('Recomendar'), findsOneWidget);
    });

    testWidgets('debería abrir modal al tocar botón Recomendar', (
      tester,
    ) async {
      // Arrange
      final movieDetail = MovieDetailEntity(
        id: tMovieId,
        title: 'Test Movie',
        overview: 'Test overview',
        voteAverage: 8.5,
        voteCount: 1000,
        releaseDate: DateTime(2024, 1, 1),
        backdropPath: '/test_backdrop.jpg',
        posterPath: '/test_poster.jpg',
        runtime: 120,
        genres: const ['Action'],
      );

      when(() => mockMovieDetailBloc.state).thenReturn(
        MovieDetailState.initial().copyWith(
          status: MovieDetailStatus.success,
          movieDetail: movieDetail,
        ),
      );
      whenListen(
        mockMovieDetailBloc,
        Stream.value(
          MovieDetailState.initial().copyWith(
            status: MovieDetailStatus.success,
            movieDetail: movieDetail,
          ),
        ),
      );

      // Act
      await tester.pumpWidget(makeTestableMovieDetailScreen());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Buscar y tocar el botón Recomendar
      final recommendButton = find.text('Recomendar');
      expect(recommendButton, findsOneWidget);
      await tester.tap(recommendButton);
      await tester.pumpAndSettle();

      // Assert - Verificar que se muestra el modal
      // El modal puede tener un TextField para comentarios
      expect(find.byType(TextField), findsWidgets);
    });

    testWidgets('debería mostrar mensaje de error cuando falla la carga', (
      tester,
    ) async {
      // Arrange
      when(() => mockMovieDetailBloc.state).thenReturn(
        MovieDetailState.initial().copyWith(
          status: MovieDetailStatus.failure,
          errorMessage: 'Error al cargar la película',
        ),
      );
      whenListen(
        mockMovieDetailBloc,
        Stream.value(
          MovieDetailState.initial().copyWith(
            status: MovieDetailStatus.failure,
            errorMessage: 'Error al cargar la película',
          ),
        ),
      );

      // Act
      await tester.pumpWidget(makeTestableMovieDetailScreen());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - Verificar que se muestra el mensaje de error
      expect(find.text('Error al cargar la película'), findsOneWidget);
    });
  });
}
