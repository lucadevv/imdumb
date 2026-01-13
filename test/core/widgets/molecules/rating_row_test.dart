import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdumb/core/theme/app_theme.dart';
import 'package:imdumb/core/widgets/molecules/rating_row.dart';

void main() {
  group('RatingRow Widget Test', () {
    testWidgets('debería mostrar el rating', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: RatingRow(rating: '8.5'),
          ),
        ),
      );

      // Assert
      expect(find.text('8.5'), findsOneWidget);
    });

    testWidgets('debería mostrar el icono de estrella', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: RatingRow(rating: '8.5'),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('debería mostrar el año cuando se proporciona', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: RatingRow(rating: '8.5', year: 2024),
          ),
        ),
      );

      // Assert
      expect(find.text('8.5'), findsOneWidget);
      expect(find.text('2024'), findsOneWidget);
    });

    testWidgets('no debería mostrar el año cuando no se proporciona',
        (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: RatingRow(rating: '8.5'),
          ),
        ),
      );

      // Assert
      expect(find.text('8.5'), findsOneWidget);
      // Verificar que no hay texto numérico de año (puede haber otros números)
      final textWidgets = find.byType(Text);
      expect(textWidgets, findsNWidgets(1)); // Solo el rating
    });

    testWidgets('debería usar tamaños personalizados', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: RatingRow(
              rating: '8.5',
              starSize: 20,
              fontSize: 16,
            ),
          ),
        ),
      );

      // Assert
      final icon = tester.widget<Icon>(find.byIcon(Icons.star));
      expect(icon.size, 20);

      final text = tester.widget<Text>(find.text('8.5'));
      expect(text.style?.fontSize, 16);
    });
  });
}
