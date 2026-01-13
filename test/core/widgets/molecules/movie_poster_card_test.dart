import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdumb/core/theme/app_theme.dart';
import 'package:imdumb/core/widgets/molecules/movie_poster_card.dart';
import 'package:imdumb/features/home/domain/entities/popular_movie_entity.dart';

void main() {
  group('MoviePosterCard Widget Test', () {
    final tMovie = PopularMovieEntity(
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
    );

    testWidgets('debería mostrar el título de la película', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: MoviePosterCard(movie: tMovie),
          ),
        ),
      );

      // Assert
      expect(find.text('Test Movie'), findsOneWidget);
    });

    testWidgets('debería mostrar la calificación', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: MoviePosterCard(movie: tMovie),
          ),
        ),
      );

      // Assert
      expect(find.text('8.0'), findsOneWidget);
    });

    testWidgets('debería contener un InkWell para interacción', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: MoviePosterCard(movie: tMovie),
          ),
        ),
      );

      // Assert - Verificar que el widget existe
      expect(find.byType(InkWell), findsOneWidget);
    });
  });
}
