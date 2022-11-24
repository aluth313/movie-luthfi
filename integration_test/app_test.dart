import 'package:dartz/dartz.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/popular_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ditonton/main.dart' as app;
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../test/dummy_data/dummy_objects.dart';
import '../test/presentation/pages/popular_tv_series_page_test.mocks.dart';
import '../test/presentation/provider/movie_list_notifier_test.mocks.dart';
import '../test/presentation/provider/tv_list_notifier_test.mocks.dart';

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
