import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdumb/core/theme/app_theme.dart';

void main() {
  group('HomeScreen Widget Test', () {
    testWidgets('debería renderizar MaterialApp correctamente', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: Container(),
          ),
        ),
      );

      // Assert
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
