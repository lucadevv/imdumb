import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:imdumb/app.dart';
import 'package:imdumb/core/constants/app_keys.dart';
import 'package:imdumb/core/constants/app_strings.dart';

import '../helpers/test_setup.dart';

/// Test de integración para Movies List Screen
///
/// Este test valida:
/// 1. Navegación de Home a Movies List Screen (Top Rated)
/// 2. Verificación de elementos en Movies List Screen
/// 3. Scroll vertical en Movies List (si es necesario)
///
/// Mejores prácticas aplicadas:
/// - Usa keys únicas (AppKeys) para encontrar widgets fácilmente
/// - Usa strings constantes (AppStrings) para verificaciones
/// - NO hace scroll vertical en Home (solo usa elementos visibles)
/// - Permite scroll vertical en Movies List (es parte de la funcionalidad)
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Movies List Screen', () {
    setUpAll(() async {
      await TestSetup.initialize();
    });

    tearDownAll(() async {
      await TestSetup.cleanup();
    });

    testWidgets(
      'debería navegar a MoviesListScreen al tocar "Ver más" de Top Rated',
      (WidgetTester tester) async {
        // ============================================
        // PASO 1: Iniciar aplicación (Splash → Home)
        // ============================================
        await tester.pumpWidget(const App());
        await tester.pumpAndSettle();
        tester.clearImage404Errors();

        // Esperar a que la pantalla Home se cargue
        await tester.waitForAny([
          find.byKey(AppKeys.homeScrollView),
          find.text(AppStrings.popularMovies),
        ], timeout: const Duration(seconds: 10));

        await tester.pumpAndSettle();
        tester.clearImage404Errors();

        // Verificar estado inicial: estamos en Home
        expect(find.text(AppStrings.popularMovies), findsOneWidget);
        expect(find.byKey(AppKeys.homeScrollView), findsOneWidget);

        // ============================================
        // PASO 2: Esperar a que las secciones se carguen
        // ============================================
        await tester.waitForAny([
          find.text(AppStrings.topRated),
          find.text(AppStrings.nowPlaying),
        ], timeout: const Duration(seconds: 15));

        await tester.pumpAndSettle();
        tester.clearImage404Errors();

        // ============================================
        // PASO 3: Buscar el botón "Ver más" de Top Rated
        // ============================================
        final viewMoreButton = find.byKey(AppKeys.topRatedViewMoreButton);
        final viewMoreText = find.text(AppStrings.viewMore);

        // Esperar a que el botón esté disponible
        bool buttonFound = false;
        for (int i = 0; i < 20; i++) {
          if (viewMoreButton.evaluate().isNotEmpty ||
              viewMoreText.evaluate().isNotEmpty) {
            buttonFound = true;
            break;
          }
          await tester.pump(const Duration(milliseconds: 500));
          tester.clearImage404Errors();
        }

        if (!buttonFound) {
          throw TimeoutException(
            'No se encontró el botón "Ver más" de Top Rated',
            const Duration(seconds: 15),
          );
        }

        await tester.pumpAndSettle();
        tester.clearImage404Errors();

        // ============================================
        // PASO 4: Hacer tap en "Ver más" (sin scroll en Home)
        // ============================================
        if (viewMoreButton.evaluate().isNotEmpty) {
          await tester.pump(const Duration(milliseconds: 300));
          tester.clearImage404Errors();
          await tester.tap(viewMoreButton);
        } else if (viewMoreText.evaluate().isNotEmpty) {
          await tester.pump(const Duration(milliseconds: 300));
          tester.clearImage404Errors();
          await tester.tap(viewMoreText);
        }

        await tester.pumpAndSettle();
        tester.clearImage404Errors();

        // ============================================
        // PASO 5: Verificar que navegamos a Movies List Screen
        // ============================================
        await tester.waitForWidget(
          find.byKey(AppKeys.moviesListBackButton),
          timeout: const Duration(seconds: 20),
        );

        expect(find.byKey(AppKeys.moviesListBackButton), findsOneWidget);
        expect(find.byKey(AppKeys.moviesListGrid), findsOneWidget);
        expect(find.byKey(AppKeys.moviesListScrollView), findsOneWidget);

        // Verificar que NO estamos en Home
        expect(find.byKey(AppKeys.homeScrollView), findsNothing);
      },
    );
  });
}
