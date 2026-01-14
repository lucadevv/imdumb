import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:imdumb/app.dart';
import 'package:imdumb/core/constants/app_keys.dart';
import 'package:imdumb/core/constants/app_strings.dart';
import 'package:imdumb/core/widgets/molecules/movie_poster_card.dart';

import '../helpers/test_setup.dart';

/// Test de integración para Movie Detail Screen
///
/// Este test valida:
/// 1. Navegación de Home a Movie Detail Screen al tocar una película
/// 2. Verificación de elementos en Movie Detail Screen (botón de retroceso)
///
/// Mejores prácticas aplicadas:
/// - Usa keys únicas (AppKeys) para encontrar widgets fácilmente
/// - Usa strings constantes (AppStrings) para verificaciones
/// - NO hace scroll vertical en Home (solo usa películas visibles)
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Movie Detail Screen', () {
    setUpAll(() async {
      await TestSetup.initialize();
    });

    tearDownAll(() async {
      await TestSetup.cleanup();
    });

    testWidgets('debería navegar a MovieDetailScreen al tocar una película', (
      WidgetTester tester,
    ) async {
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
      // PASO 2: Esperar a que las películas se carguen
      // ============================================
      await tester.waitForAny([
        find.byKey(AppKeys.moviePosterCard(550)),
        find.byType(MoviePosterCard),
      ], timeout: const Duration(seconds: 10));

      await tester.pump(const Duration(milliseconds: 500));
      tester.clearImage404Errors();

      // ============================================
      // PASO 3: Buscar una película visible (sin scroll en Home)
      // ============================================
      final movieCard = find.byKey(AppKeys.moviePosterCard(550));
      final moviePosterCards = find.byType(MoviePosterCard);

      Finder? cardToTap;
      if (movieCard.evaluate().isNotEmpty) {
        cardToTap = movieCard.first;
      } else if (moviePosterCards.evaluate().isNotEmpty) {
        cardToTap = moviePosterCards.first;
      } else {
        throw Exception('No se encontró ninguna película para tocar');
      }

      // ============================================
      // PASO 4: Hacer tap en la película (sin ensureVisible para evitar scroll)
      // ============================================
      if (cardToTap.evaluate().isNotEmpty) {
        // NO hacer ensureVisible para evitar scroll vertical en Home
        await tester.pump(const Duration(milliseconds: 300));
        tester.clearImage404Errors();

        await tester.tap(cardToTap, warnIfMissed: false);
        await tester.pumpAndSettle();
        tester.clearImage404Errors();

        // ============================================
        // PASO 5: Verificar que navegamos a Movie Detail Screen
        // ============================================
        await tester.waitForWidget(
          find.byKey(AppKeys.movieDetailBackButton),
          timeout: const Duration(seconds: 20),
        );

        expect(find.byKey(AppKeys.movieDetailBackButton), findsOneWidget);
        expect(find.byKey(AppKeys.movieDetailScrollView), findsOneWidget);

        // Verificar que NO estamos en Home
        expect(find.byKey(AppKeys.homeScrollView), findsNothing);
      }
    });
  });
}
