import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:imdumb/app.dart';
import 'package:imdumb/core/constants/app_keys.dart';
import 'package:imdumb/core/constants/app_strings.dart';

import '../helpers/test_setup.dart';

/// Test de integración para Splash to Home Flow
///
/// Este test valida:
/// 1. Navegación de Splash Screen a Home Screen
/// 2. Verificación de elementos principales en Home Screen
///
/// Mejores prácticas aplicadas:
/// - Usa keys únicas (AppKeys) para encontrar widgets fácilmente
/// - Usa strings constantes (AppStrings) para verificaciones
/// - Verifica estados después de la navegación
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Splash to Home Flow', () {
    setUpAll(() async {
      await TestSetup.initialize();
    });

    tearDownAll(() async {
      await TestSetup.cleanup();
    });

    testWidgets(
      'debería navegar de SplashScreen a HomeScreen',
      (WidgetTester tester) async {
        // ============================================
        // PASO 1: Iniciar aplicación (Splash → Home)
        // ============================================
        await tester.pumpWidget(const App());
        await tester.pumpAndSettle();
        tester.clearImage404Errors();

        // ============================================
        // PASO 2: Esperar a que la pantalla Home se cargue
        // ============================================
        await tester.waitForAny([
          find.byKey(AppKeys.homeScrollView),
          find.text(AppStrings.popularMovies),
        ], timeout: const Duration(seconds: 10));

        await tester.pumpAndSettle();
        tester.clearImage404Errors();

        // ============================================
        // PASO 3: Verificar que estamos en Home Screen
        // ============================================
        expect(find.text(AppStrings.popularMovies), findsOneWidget);
        expect(find.byKey(AppKeys.homeScrollView), findsOneWidget);
      },
    );
  });
}
