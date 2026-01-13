import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:imdumb/app.dart';
import 'package:imdumb/core/constants/app_keys.dart';
import 'package:imdumb/core/constants/app_strings.dart';

import '../helpers/test_setup.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Movies List Screen', () {
    setUpAll(() async {
      await TestSetup.initialize();
    });

    tearDownAll(() async {
      await TestSetup.cleanup();
    });

    testWidgets('debería navegar a MoviesListScreen al tocar "Ver más" de Top Rated', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      await tester.waitForAny(
        [
          find.byKey(AppKeys.homeScrollView),
          find.text(AppStrings.popularMovies),
        ],
        timeout: const Duration(seconds: 10),
      );

      await tester.pumpAndSettle();

      await tester.waitForAny(
        [
          find.text(AppStrings.topRated),
          find.text(AppStrings.nowPlaying),
        ],
        timeout: const Duration(seconds: 15),
      );

      await tester.pumpAndSettle();

      final viewMoreButton = find.byKey(AppKeys.topRatedViewMoreButton);
      final viewMoreText = find.text(AppStrings.viewMore);

      bool buttonFound = false;
      for (int i = 0; i < 20; i++) {
        if (viewMoreButton.evaluate().isNotEmpty || viewMoreText.evaluate().isNotEmpty) {
          buttonFound = true;
          break;
        }
        await tester.pump(const Duration(milliseconds: 500));
        tester.clearImage404Errors();
      }

      if (!buttonFound) {
        throw TimeoutException(
          'No se encontró el botón "Ver más"',
          const Duration(seconds: 15),
        );
      }

      await tester.pumpAndSettle();

      if (viewMoreButton.evaluate().isNotEmpty) {
        await tester.ensureVisible(viewMoreButton);
        await tester.pump(const Duration(milliseconds: 100));
        tester.clearImage404Errors();
        await tester.tap(viewMoreButton);
      } else {
        await tester.ensureVisible(viewMoreText);
        await tester.pump(const Duration(milliseconds: 100));
        tester.clearImage404Errors();
        await tester.tap(viewMoreText);
      }

      await tester.pumpAndSettle();

      await tester.waitForWidget(
        find.byKey(AppKeys.moviesListBackButton),
        timeout: const Duration(seconds: 20),
      );

      expect(find.byKey(AppKeys.moviesListBackButton), findsOneWidget);
      expect(find.byKey(AppKeys.moviesListGrid), findsOneWidget);
    });
  });
}
