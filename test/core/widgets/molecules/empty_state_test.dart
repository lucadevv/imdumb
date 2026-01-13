import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdumb/core/theme/app_theme.dart';
import 'package:imdumb/core/widgets/molecules/empty_state.dart';

void main() {
  group('EmptyState Widget Test', () {
    testWidgets('debería mostrar el mensaje personalizado', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: EmptyState(message: 'No hay películas disponibles'),
          ),
        ),
      );

      // Assert
      expect(find.text('No hay películas disponibles'), findsOneWidget);
    });

    testWidgets('debería mostrar mensaje por defecto cuando no se proporciona',
        (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: EmptyState(),
          ),
        ),
      );

      // Assert
      expect(find.text('No hay información disponible'), findsOneWidget);
    });

    testWidgets('debería estar centrado en la pantalla', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: EmptyState(message: 'Lista vacía'),
          ),
        ),
      );

      // Assert
      expect(find.byType(Center), findsOneWidget);
      expect(find.text('Lista vacía'), findsOneWidget);
    });

    testWidgets('debería tener texto alineado al centro', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: EmptyState(message: 'Lista vacía'),
          ),
        ),
      );

      // Assert
      final textWidget = tester.widget<Text>(find.text('Lista vacía'));
      expect(textWidget.textAlign, TextAlign.center);
    });
  });
}
