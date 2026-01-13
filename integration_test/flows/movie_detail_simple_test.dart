import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:imdumb/app.dart';
import 'package:imdumb/core/constants/app_keys.dart';
import 'package:imdumb/core/constants/app_strings.dart';
import 'package:imdumb/core/widgets/molecules/movie_poster_card.dart';

import '../helpers/test_setup.dart';

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
          find.byKey(AppKeys.moviePosterCard(550)),
          find.byType(MoviePosterCard),
        ],
        timeout: const Duration(seconds: 10),
      );

      await tester.pumpAndSettle();

      final movieCard = find.byKey(AppKeys.moviePosterCard(550));
      final moviePosterCards = find.byType(MoviePosterCard);

      Finder cardToTap;
      if (movieCard.evaluate().isNotEmpty) {
        cardToTap = movieCard.first;
      } else if (moviePosterCards.evaluate().isNotEmpty) {
        cardToTap = moviePosterCards.first;
      } else {
        throw Exception('No se encontró ninguna película para tocar');
      }

      await tester.ensureVisible(cardToTap);
      await tester.pump(const Duration(milliseconds: 100));
      tester.clearImage404Errors();

      await tester.tap(cardToTap);
      await tester.pumpAndSettle();

      await tester.waitForWidget(
        find.byKey(AppKeys.movieDetailBackButton),
        timeout: const Duration(seconds: 20),
      );

      expect(find.byKey(AppKeys.movieDetailBackButton), findsOneWidget);
    });
  });
}
