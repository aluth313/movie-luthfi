import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ditonton/main.dart' as app;
import 'package:mockito/mockito.dart';

import '../test/presentation/pages/popular_tv_series_page_test.mocks.dart';

void main() {
  // IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // late MockPopularTvSeriesNotifier mockNotifier;

  // setUp(() {
  //   mockNotifier = MockPopularTvSeriesNotifier();
  // });

  // testWidgets('Page should display ListView when data is loaded',
  //     (WidgetTester tester) async {
  //   app.main();
  //   when(mockNotifier.state).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.tvSeries).thenReturn(<Tv>[]);

  //   final listViewFinder = find.byType(ListView);

  //   await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));

  //   expect(listViewFinder, findsOneWidget);
  // })
}
