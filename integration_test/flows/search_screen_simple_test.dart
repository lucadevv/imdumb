import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:imdumb/app.dart';
import 'package:imdumb/core/constants/app_keys.dart';
import 'package:imdumb/core/constants/app_strings.dart';

import '../helpers/test_setup.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Search Screen', () {
    setUpAll(() async {
      await TestSetup.initialize();
    });

    tearDownAll(() async {
      await TestSetup.cleanup();
    });

    testWidgets('debería navegar a SearchScreen y mostrar campo de búsqueda', (
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
          find.byKey(AppKeys.homeSearchButton),
          find.byType(SliverAppBar),
        ],
        timeout: const Duration(seconds: 15),
      );

      await tester.pumpAndSettle();

      await tester.waitForWidget(
        find.byKey(AppKeys.homeSearchButton),
        timeout: const Duration(seconds: 20),
      );

      expect(find.byKey(AppKeys.homeSearchButton), findsOneWidget);

      await tester.ensureVisible(find.byKey(AppKeys.homeSearchButton));
      await tester.pump(const Duration(milliseconds: 100));
      tester.clearImage404Errors();

      await tester.tap(find.byKey(AppKeys.homeSearchButton));
      await tester.pumpAndSettle();

      expect(find.byKey(AppKeys.searchTextField), findsOneWidget);
      expect(find.byKey(AppKeys.searchBackButton), findsOneWidget);
    });
  });
}
