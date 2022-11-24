import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ditonton/main.dart' as app;

void main() {
  group('Popular Series test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets(
        'Page should success add to watchlist when data is loaded & button watchlist is clicked',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final scrollViewFinder = find.byKey(Key('scroll_view_key'));
      await tester.fling(scrollViewFinder, Offset(0, -500), 10000);
      await tester.pumpAndSettle();

      final seriesItem = find.byKey(Key('popular_series_item0'));
      await tester.ensureVisible(seriesItem);
      await tester.tap(seriesItem);
      await tester.pumpAndSettle();

      final scrollViewDetailFinder = find.byKey(Key('scroll_view_detail_key'));
      final watchListButtonFinder = find.byKey(Key('watchlist_button_key'));
      await tester.fling(scrollViewDetailFinder, Offset(0, -500), 10000);
      await tester.pumpAndSettle();
      await tester.fling(scrollViewDetailFinder, Offset(0, 500), 10000);
      await tester.pumpAndSettle();

      await tester.ensureVisible(watchListButtonFinder);
      await tester.tap(watchListButtonFinder);
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added to Watchlist'), findsOneWidget);
    });
  });
}
