import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:imdumb/app.dart';
import 'package:imdumb/core/constants/app_keys.dart';
import 'package:imdumb/core/constants/app_strings.dart';

import '../helpers/test_setup.dart';

/// Test de integración para Search Screen
///
/// Este test valida:
/// 1. Navegación de Home a Search Screen
/// 2. Verificación de elementos en Search Screen (campo de búsqueda, botón de retroceso)
///
/// Mejores prácticas aplicadas:
/// - Usa keys únicas (AppKeys) para encontrar widgets fácilmente
/// - Usa strings constantes (AppStrings) para verificaciones
/// - NO hace scroll vertical en Home (solo usa elementos visibles)
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Search Screen', () {
    setUpAll(() async {
      await TestSetup.initialize();
    });

    tearDownAll(() async {
      await TestSetup.cleanup();
    });

    testWidgets(
      'debería navegar a SearchScreen y mostrar campo de búsqueda',
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
        // PASO 2: Esperar a que el botón de búsqueda esté disponible
        // ============================================
        await tester.waitForAny([
          find.byKey(AppKeys.homeSearchButton),
          find.byType(SliverAppBar),
        ], timeout: const Duration(seconds: 15));

        await tester.pumpAndSettle();
        tester.clearImage404Errors();

        await tester.waitForWidget(
          find.byKey(AppKeys.homeSearchButton),
          timeout: const Duration(seconds: 20),
        );

        expect(find.byKey(AppKeys.homeSearchButton), findsOneWidget);

        // ============================================
        // PASO 3: Hacer tap en el botón de búsqueda (sin scroll en Home)
        // ============================================
        await tester.pump(const Duration(milliseconds: 300));
        tester.clearImage404Errors();

        await tester.tap(find.byKey(AppKeys.homeSearchButton));
        await tester.pumpAndSettle();
        tester.clearImage404Errors();

        // ============================================
        // PASO 4: Verificar que navegamos a Search Screen
        // ============================================
        expect(find.byKey(AppKeys.searchTextField), findsOneWidget);
        expect(find.byKey(AppKeys.searchBackButton), findsOneWidget);
        expect(find.byKey(AppKeys.searchScrollView), findsOneWidget);

        // Verificar que NO estamos en Home
        expect(find.byKey(AppKeys.homeScrollView), findsNothing);
        expect(find.byKey(AppKeys.homeSearchButton), findsNothing);
      },
    );
  });
}
