import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:imdumb/app.dart';
import 'package:imdumb/core/constants/app_keys.dart';
import 'package:imdumb/core/constants/app_strings.dart';

import '../helpers/test_setup.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Splash to Home Flow', () {
    setUpAll(() async {
      await TestSetup.initialize();
    });

    tearDownAll(() async {
      await TestSetup.cleanup();
    });

    testWidgets('debería navegar de SplashScreen a HomeScreen', (
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

      expect(find.text(AppStrings.popularMovies), findsOneWidget);
    });
  });
}
