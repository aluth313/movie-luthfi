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

import '../test/presentation/pages/popular_tv_series_page_test.mocks.dart';
import '../test/presentation/provider/movie_list_notifier_test.mocks.dart';
import '../test/presentation/provider/tv_list_notifier_test.mocks.dart';

void main() {
  group('Popular Series test', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    late TvListNotifier provider;
    late PopularTvSeriesNotifier providerPopularSeries;
    late MockGetAiringTodaySeries mockGetAiringTodaySeries;
    late MockGetPopularTv mockGetPopularSeries;
    late MockGetTopRatedSeries mockGetTopRatedSeries;
    late MovieListNotifier providerMovies;
    late MockGetNowPlayingMovies mockGetNowPlayingMovies;
    late MockGetPopularMovies mockGetPopularMovies;
    late MockGetTopRatedMovies mockGetTopRatedMovies;
    late MockPopularTvSeriesNotifier mockPopularTvSeriesNotifier;
    late int listenerCallCount;

    setUp(() {
      listenerCallCount = 0;
      mockGetAiringTodaySeries = MockGetAiringTodaySeries();
      mockGetPopularSeries = MockGetPopularTv();
      mockGetTopRatedSeries = MockGetTopRatedSeries();
      mockGetNowPlayingMovies = MockGetNowPlayingMovies();
      mockGetPopularMovies = MockGetPopularMovies();
      mockGetTopRatedMovies = MockGetTopRatedMovies();
      mockPopularTvSeriesNotifier = MockPopularTvSeriesNotifier();
      providerMovies = MovieListNotifier(
        getNowPlayingMovies: mockGetNowPlayingMovies,
        getPopularMovies: mockGetPopularMovies,
        getTopRatedMovies: mockGetTopRatedMovies,
      )..addListener(() {
          listenerCallCount += 1;
        });
      provider = TvListNotifier(
        getAiringTodaySeries: mockGetAiringTodaySeries,
        getPopularTv: mockGetPopularSeries,
        getTopRatedSeries: mockGetTopRatedSeries,
      )..addListener(() {
          listenerCallCount += 1;
        });
      providerPopularSeries = PopularTvSeriesNotifier(mockGetPopularSeries);
    });

    final tSeries = Tv(
      backdropPath: '/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg',
      genreIds: [18, 9648],
      id: 31917,
      originalName: 'Pretty Little Liars',
      overview:
          'Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.',
      popularity: 47.432451,
      posterPath: '/vC324sdfcS313vh9QXwijLIHPJp.jpg',
      firstAirDate: '2010-06-08',
      name: 'Pretty Little Liars',
      voteAverage: 5.04,
      voteCount: 133,
      originCountry: ['US'],
      originalLanguage: 'en',
    );
    final tSeriesList = <Tv>[tSeries];

    Widget _makeHomePage(Widget body) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<MovieListNotifier>.value(
            value: providerMovies,
            child: MaterialApp(
              home: body,
            ),
          ),
          ChangeNotifierProvider<TvListNotifier>.value(
            value: provider,
            child: MaterialApp(
              home: body,
            ),
          ),
        ],
      );
    }

    Widget _makePopularSeriesPage(Widget body) {
      return ChangeNotifierProvider<PopularTvSeriesNotifier>.value(
        value: providerPopularSeries,
        child: MaterialApp(
          home: body,
        ),
      );
    }

    testWidgets(
        'Page should success add to watchlist when data is loaded & button watchlist is clicked',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpWidget(_makeHomePage(HomeMoviePage()));
      await tester.pumpAndSettle();

      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));

      provider.fetchPopularTv();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('popular_series')));

      await tester.pumpWidget(_makePopularSeriesPage(PopularTvSeriesPage()));
      await tester.pumpAndSettle();

      when(mockPopularTvSeriesNotifier.fetchPopularTvSeries())
          .thenAnswer((_) async => Right(tSeriesList));

      providerPopularSeries.fetchPopularTvSeries();

      when(mockPopularTvSeriesNotifier.state).thenReturn(RequestState.Loaded);
      when(mockPopularTvSeriesNotifier.tvSeries).thenReturn(<Tv>[]);

      final listViewFinder = find.byType(ListView);

      await tester.scrollUntilVisible(listViewFinder, 5000);
      expect(listViewFinder, findsOneWidget);
    });
  });
}
