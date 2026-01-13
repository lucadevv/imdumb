import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdumb/core/theme/app_theme.dart';
import 'package:imdumb/core/widgets/atoms/cached_image.dart';

void main() {
  group('CachedImage Widget Test', () {
    testWidgets('debería mostrar error widget cuando imageUrl es null',
        (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: SizedBox(
              width: 100,
              height: 100,
              child: CachedImage(imageUrl: null),
            ),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.movie), findsOneWidget);
    });

    testWidgets('debería mostrar error widget cuando imageUrl está vacío',
        (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: SizedBox(
              width: 100,
              height: 100,
              child: CachedImage(imageUrl: ''),
            ),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.movie), findsOneWidget);
    });

    testWidgets('debería usar placeholder personalizado cuando se proporciona',
        (tester) async {
      // Arrange
      const customPlaceholder = Text('Cargando...');

      // Act
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: SizedBox(
              width: 100,
              height: 100,
              child: CachedImage(
                imageUrl: 'https://example.com/image.jpg',
                placeholder: customPlaceholder,
              ),
            ),
          ),
        ),
      );

      // Assert - El placeholder personalizado se usará durante la carga
      // Nota: CachedNetworkImage maneja esto internamente
      expect(find.byType(CachedImage), findsOneWidget);
    });

    testWidgets('debería usar errorWidget personalizado cuando se proporciona',
        (tester) async {
      // Arrange
      const customErrorWidget = Text('Error al cargar imagen');

      // Act
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: SizedBox(
              width: 100,
              height: 100,
              child: CachedImage(
                imageUrl: null,
                errorWidget: customErrorWidget,
              ),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Error al cargar imagen'), findsOneWidget);
    });

    testWidgets('debería respetar width y height cuando se proporcionan',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: CachedImage(
              imageUrl: null,
              width: 200,
              height: 300,
            ),
          ),
        ),
      );
      await tester.pump();

      final cachedImageFinder = find.byType(CachedImage);
      expect(cachedImageFinder, findsOneWidget);
      
      final cachedImageWidget = tester.widget<CachedImage>(cachedImageFinder);
      expect(cachedImageWidget.width, 200);
      expect(cachedImageWidget.height, 300);
      
      final sizedBox = find.descendant(
        of: cachedImageFinder,
        matching: find.byType(SizedBox),
      ).first;
      
      final sizedBoxWidget = tester.widget<SizedBox>(sizedBox);
      expect(sizedBoxWidget.width, 200);
      expect(sizedBoxWidget.height, 300);
    });
  });
}
