import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:imdumb/app.dart';
import 'package:imdumb/core/constants/app_keys.dart';
import 'package:imdumb/core/constants/app_strings.dart';
import 'package:imdumb/core/widgets/molecules/movie_poster_card.dart';

import '../helpers/test_setup.dart';

/// Test de integración completo que navega por todas las pantallas de la aplicación
///
/// Este test valida el flujo completo de navegación end-to-end (E2E):
/// 1. Splash → Home: Verificar que la aplicación inicia correctamente
/// 2. Home → Movies List (Top Rated): Navegar a lista de películas mejor valoradas
/// 3. Movies List → Home (back): Volver a la pantalla principal
/// 4. Home → Search: Navegar a la pantalla de búsqueda
/// 5. Search: Realizar una búsqueda de películas
/// 6. Search → Home (back): Volver a la pantalla principal
/// 7. Home → Movie Detail: Navegar al detalle de una película
/// 8. Movie Detail → Home (back): Volver a la pantalla principal
///
/// Mejores prácticas aplicadas:
/// - Usa keys únicas (AppKeys) para encontrar widgets fácilmente
/// - Usa strings constantes (AppStrings) para verificaciones
/// - Verifica estados antes y después de cada interacción
/// - Simula interacciones reales del usuario
/// - Valida navegación completa entre pantallas
/// - Maneja scroll y widgets fuera de la vista
void main() {
  // Inicializa el binding necesario para ejecutar tests de integración
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Navegación Completa por Todas las Pantallas', () {
    setUpAll(() async {
      await TestSetup.initialize();
    });

    tearDownAll(() async {
      await TestSetup.cleanup();
    });

    testWidgets(
      'debería navegar por todas las pantallas de la aplicación correctamente',
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
        expect(find.byKey(AppKeys.homeSearchButton), findsOneWidget);
        expect(find.byKey(AppKeys.homeMenuButton), findsOneWidget);
        expect(find.byKey(AppKeys.homeScrollView), findsOneWidget);

        // ============================================
        // PASO 2: Home → Movies List (Top Rated)
        // ============================================
        // Esperar a que las secciones se carguen
        await tester.waitForAny([
          find.text(AppStrings.topRated),
          find.text(AppStrings.nowPlaying),
        ], timeout: const Duration(seconds: 15));

        await tester.pumpAndSettle();
        tester.clearImage404Errors();

        // Buscar el botón "Ver más" de Top Rated
        final topRatedViewMoreButton = find.byKey(
          AppKeys.topRatedViewMoreButton,
        );
        final viewMoreText = find.text(AppStrings.viewMore);

        // Esperar a que el botón esté disponible
        bool buttonFound = false;
        for (int i = 0; i < 20; i++) {
          if (topRatedViewMoreButton.evaluate().isNotEmpty ||
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

        // Verificar que el botón está visible antes de hacer tap
        if (topRatedViewMoreButton.evaluate().isNotEmpty) {
          await tester.pump(const Duration(milliseconds: 300));
          tester.clearImage404Errors();
          await tester.tap(topRatedViewMoreButton);
        } else if (viewMoreText.evaluate().isNotEmpty) {
          await tester.pump(const Duration(milliseconds: 300));
          tester.clearImage404Errors();
          await tester.tap(viewMoreText);
        }

        await tester.pumpAndSettle();
        tester.clearImage404Errors();

        // Verificar que navegamos a Movies List Screen
        await tester.waitForWidget(
          find.byKey(AppKeys.moviesListBackButton),
          timeout: const Duration(seconds: 20),
        );

        expect(find.byKey(AppKeys.moviesListBackButton), findsOneWidget);
        expect(find.byKey(AppKeys.moviesListGrid), findsOneWidget);
        expect(find.byKey(AppKeys.moviesListScrollView), findsOneWidget);

        // Verificar que NO estamos en Home
        expect(find.byKey(AppKeys.homeScrollView), findsNothing);

        // ============================================
        // PASO 3: Movies List → Home (back)
        // ============================================
        await tester.tap(find.byKey(AppKeys.moviesListBackButton));
        await tester.pumpAndSettle();
        tester.clearImage404Errors();

        // Esperar a que volvamos a Home
        await tester.waitForWidget(
          find.byKey(AppKeys.homeScrollView),
          timeout: const Duration(seconds: 10),
        );

        await tester.pumpAndSettle();
        tester.clearImage404Errors();

        // Verificar que estamos de vuelta en Home
        expect(find.byKey(AppKeys.homeScrollView), findsOneWidget);
        expect(find.byKey(AppKeys.moviesListBackButton), findsNothing);

        // ============================================
        // PASO 4: Home → Search
        // ============================================
        // Verificar que el botón de búsqueda está visible
        await tester.waitForWidget(
          find.byKey(AppKeys.homeSearchButton),
          timeout: const Duration(seconds: 20),
        );

        expect(find.byKey(AppKeys.homeSearchButton), findsOneWidget);

        await tester.pump(const Duration(milliseconds: 300));
        tester.clearImage404Errors();

        // Hacer tap en el botón de búsqueda
        await tester.tap(find.byKey(AppKeys.homeSearchButton));
        await tester.pumpAndSettle();
        tester.clearImage404Errors();

        // Verificar que navegamos a Search Screen
        expect(find.byKey(AppKeys.searchTextField), findsOneWidget);
        expect(find.byKey(AppKeys.searchBackButton), findsOneWidget);
        expect(find.byKey(AppKeys.searchScrollView), findsOneWidget);

        // Verificar que NO estamos en Home
        expect(find.byKey(AppKeys.homeScrollView), findsNothing);
        expect(find.byKey(AppKeys.homeSearchButton), findsNothing);

        // ============================================
        // PASO 5: Realizar una búsqueda en Search
        // ============================================
        // Verificar estado inicial del campo de búsqueda
        expect(find.byKey(AppKeys.searchTextField), findsOneWidget);

        // Escribir texto en el campo de búsqueda
        const searchQuery = 'test';
        await tester.tap(find.byKey(AppKeys.searchTextField));
        await tester.pumpAndSettle();
        tester.clearImage404Errors();

        await tester.enterText(
          find.byKey(AppKeys.searchTextField),
          searchQuery,
        );
        await tester.pumpAndSettle(const Duration(seconds: 2));
        tester.clearImage404Errors();

        // Verificar que el campo de búsqueda sigue visible después de ingresar texto
        expect(find.byKey(AppKeys.searchTextField), findsOneWidget);

        // ============================================
        // PASO 6: Search → Home (back)
        // ============================================
        await tester.tap(find.byKey(AppKeys.searchBackButton));
        await tester.pumpAndSettle();
        tester.clearImage404Errors();

        // Esperar a que volvamos a Home
        await tester.waitForWidget(
          find.byKey(AppKeys.homeScrollView),
          timeout: const Duration(seconds: 10),
        );

        await tester.pumpAndSettle();
        tester.clearImage404Errors();

        // Verificar que estamos de vuelta en Home
        expect(find.byKey(AppKeys.homeScrollView), findsOneWidget);
        expect(find.byKey(AppKeys.homeSearchButton), findsOneWidget);
        expect(find.byKey(AppKeys.searchTextField), findsNothing);

        // ============================================
        // PASO 7: Home → Movie Detail
        // ============================================
        // Esperar a que las películas se carguen
        await tester.waitForAny([
          find.byKey(AppKeys.moviePosterCard(550)),
          find.byType(MoviePosterCard),
        ], timeout: const Duration(seconds: 10));

        await tester.pump(const Duration(milliseconds: 500));
        tester.clearImage404Errors();

        // Buscar películas visibles sin hacer scroll en Home
        final movieCard = find.byKey(AppKeys.moviePosterCard(550));
        final moviePosterCards = find.byType(MoviePosterCard);

        Finder? cardToTap;
        if (movieCard.evaluate().isNotEmpty) {
          cardToTap = movieCard.first;
        } else if (moviePosterCards.evaluate().isNotEmpty) {
          cardToTap = moviePosterCards.first;
        }

        // Si encontramos una tarjeta visible, hacer tap sin scroll
        if (cardToTap != null && cardToTap.evaluate().isNotEmpty) {
          // NO hacer ensureVisible para evitar scroll vertical en Home
          await tester.pump(const Duration(milliseconds: 300));
          tester.clearImage404Errors();

          // Hacer tap en la tarjeta de película
          await tester.tap(cardToTap, warnIfMissed: false);
          await tester.pumpAndSettle();
          tester.clearImage404Errors();

          // Verificar que navegamos a Movie Detail Screen
          await tester.waitForWidget(
            find.byKey(AppKeys.movieDetailBackButton),
            timeout: const Duration(seconds: 20),
          );

          expect(find.byKey(AppKeys.movieDetailBackButton), findsOneWidget);
          expect(find.byKey(AppKeys.movieDetailScrollView), findsOneWidget);

          // Verificar que NO estamos en Home
          expect(find.byKey(AppKeys.homeScrollView), findsNothing);

          // ============================================
          // PASO 8: Movie Detail → Home (back)
          // ============================================
          await tester.tap(find.byKey(AppKeys.movieDetailBackButton));
          await tester.pump(const Duration(milliseconds: 500));
          tester.clearImage404Errors();

          // Esperar a que volvamos a Home sin hacer pumpAndSettle que puede causar scroll
          await tester.waitForWidget(
            find.byKey(AppKeys.homeScrollView),
            timeout: const Duration(seconds: 10),
          );

          await tester.pump(const Duration(milliseconds: 500));
          tester.clearImage404Errors();

          // Verificar que estamos de vuelta en Home (estado final)
          expect(find.byKey(AppKeys.homeScrollView), findsOneWidget);
          expect(find.byKey(AppKeys.homeSearchButton), findsOneWidget);
          expect(find.byKey(AppKeys.movieDetailBackButton), findsNothing);
        }

        // Verificación final: estamos en Home
        expect(find.byKey(AppKeys.homeScrollView), findsOneWidget);
      },
    );
  });
}
