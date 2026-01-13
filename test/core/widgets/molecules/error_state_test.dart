import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdumb/core/theme/app_theme.dart';
import 'package:imdumb/core/widgets/molecules/error_state.dart';

void main() {
  group('ErrorState Widget Test', () {
    testWidgets('debería mostrar el mensaje de error', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(body: ErrorState(errorMessage: 'Error de conexión')),
        ),
      );

      // Assert
      expect(find.text('Error de conexión'), findsOneWidget);
    });

    testWidgets(
      'debería mostrar mensaje por defecto cuando no se proporciona',
      (tester) async {
        // Arrange & Act
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.dark(),
            home: Scaffold(body: ErrorState()),
          ),
        );

        // Assert
        expect(find.text('Error al cargar'), findsOneWidget);
      },
    );

    testWidgets(
      'debería mostrar botón de reintentar cuando se proporciona onRetry',
      (tester) async {
        // Arrange
        bool retryCalled = false;

        // Act
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.dark(),
            home: Scaffold(
              body: ErrorState(
                errorMessage: 'Error de conexión',
                onRetry: () {
                  retryCalled = true;
                },
              ),
            ),
          ),
        );

        // Assert
        expect(find.text('Reintentar'), findsOneWidget);
        expect(find.byType(ElevatedButton), findsOneWidget);

        // Tap en el botón
        await tester.tap(find.text('Reintentar'));
        await tester.pump();
        expect(retryCalled, true);
      },
    );

    testWidgets('no debería mostrar botón cuando onRetry es null', (
      tester,
    ) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(body: ErrorState(errorMessage: 'Error de conexión')),
        ),
      );

      // Assert
      expect(find.text('Reintentar'), findsNothing);
      expect(find.byType(ElevatedButton), findsNothing);
    });

    testWidgets('debería usar label personalizado para el botón', (
      tester,
    ) async {
      // Arrange

      // Act
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ErrorState(
              errorMessage: 'Error de conexión',
              onRetry: () {},
              retryLabel: 'Volver a intentar',
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Volver a intentar'), findsOneWidget);
      expect(find.text('Reintentar'), findsNothing);
    });
  });
}
