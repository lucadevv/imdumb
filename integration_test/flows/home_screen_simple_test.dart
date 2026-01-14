import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:imdumb/app.dart';
import 'package:imdumb/core/constants/app_keys.dart';
import 'package:imdumb/core/constants/app_strings.dart';

import '../helpers/test_setup.dart';

/// Test de integración para Home Screen
///
/// Este test valida:
/// 1. Navegación de Splash a Home Screen
/// 2. Verificación de secciones principales en Home
/// 3. Verificación de botones "Ver más" en las secciones
/// 4. Verificación de elementos del AppBar (búsqueda, menú)
///
/// Mejores prácticas aplicadas:
/// - Usa keys únicas (AppKeys) para encontrar widgets fácilmente
/// - Usa strings constantes (AppStrings) para verificaciones
/// - NO hace scroll vertical (solo verifica elementos visibles)
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Home Screen', () {
    setUpAll(() async {
      await TestSetup.initialize();
    });

    tearDownAll(() async {
      await TestSetup.cleanup();
    });

    testWidgets(
      'debería mostrar todas las secciones principales',
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

        // ============================================
        // PASO 2: Verificar secciones principales
        // ============================================
        expect(find.text(AppStrings.popularMovies), findsOneWidget);
        expect(find.text(AppStrings.topRated), findsOneWidget);
        expect(find.text(AppStrings.nowPlaying), findsOneWidget);
        expect(find.byKey(AppKeys.homeScrollView), findsOneWidget);
      },
    );

    testWidgets(
      'debería mostrar botones "Ver más" en las secciones',
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

        // Esperar a que las secciones se carguen
        await tester.waitForAny([
          find.text(AppStrings.topRated),
          find.text(AppStrings.nowPlaying),
        ], timeout: const Duration(seconds: 15));

        await tester.pumpAndSettle();
        tester.clearImage404Errors();

        // ============================================
        // PASO 2: Verificar botones "Ver más"
        // ============================================
        expect(find.byKey(AppKeys.topRatedViewMoreButton), findsOneWidget);
        expect(find.byKey(AppKeys.nowPlayingViewMoreButton), findsOneWidget);
      },
    );

    testWidgets(
      'debería mostrar el botón de búsqueda en el AppBar',
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

        // ============================================
        // PASO 2: Verificar botón de búsqueda
        // ============================================
        expect(find.byKey(AppKeys.homeSearchButton), findsOneWidget);
        expect(find.byKey(AppKeys.homeScrollView), findsOneWidget);
      },
    );

    testWidgets(
      'debería mostrar el botón de menú en el AppBar',
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

        // ============================================
        // PASO 2: Verificar botón de menú
        // ============================================
        expect(find.byKey(AppKeys.homeMenuButton), findsOneWidget);
        expect(find.byKey(AppKeys.homeScrollView), findsOneWidget);
      },
    );
  });
}
