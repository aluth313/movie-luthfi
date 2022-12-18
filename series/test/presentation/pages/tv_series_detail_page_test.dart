import 'package:bloc_test/bloc_test.dart';
import 'package:series/domain/entities/tv.dart';
import 'package:series/presentation/bloc/episodes_bloc.dart';
import 'package:series/presentation/bloc/selected_season_bloc.dart';
import 'package:series/presentation/bloc/tv_series_detail_bloc.dart';
import 'package:series/presentation/bloc/tv_series_recommendations_bloc.dart';
import 'package:series/presentation/bloc/watchlist_tv_series_bloc.dart';
import 'package:series/presentation/bloc/watchlist_tv_series_status_bloc.dart';
import 'package:series/presentation/pages/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../../../test/dummy_data/dummy_objects.dart';

class MockTvSeriesDetailBloc
    extends MockBloc<TvSeriesDetailEvent, TvSeriesDetailState>
    implements TvSeriesDetailBloc {}

class MockTvSeriesRecommendationsBloc
    extends MockBloc<TvSeriesRecommendationsEvent, TvSeriesRecommendationsState>
    implements TvSeriesRecommendationsBloc {}

class MockWatchlistTvSeriesBloc
    extends MockBloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState>
    implements WatchlistTvSeriesBloc {}

class MockWatchlistTvSeriesStatusBloc
    extends MockBloc<WatchlistTvSeriesStatusEvent, WatchlistTvSeriesStatusState>
    implements WatchlistTvSeriesStatusBloc {}

class MockSelectedSeasonBloc
    extends MockBloc<SelectedSeasonEvent, SelectedSeasonState>
    implements SelectedSeasonBloc {}

class MockEpisodesBloc extends MockBloc<EpisodesEvent, EpisodesState>
    implements EpisodesBloc {}

class MockTvSeriesDetailEvent extends Fake implements TvSeriesDetailEvent {}

class MockSelectedSeasonEvent extends Fake implements SelectedSeasonEvent {}

class MockEpisodesEvent extends Fake implements EpisodesEvent {}

class MockWatchlistTvSeriesStatusEvent extends Fake
    implements WatchlistTvSeriesStatusEvent {}

class MockTvSeriesRecommendationsEvent extends Fake
    implements TvSeriesRecommendationsEvent {}

class MockWatchlistTvSeriesEvent extends Fake
    implements WatchlistTvSeriesEvent {}

class MockTvSeriesDetailState extends Fake implements TvSeriesDetailState {}

class MockSelectedSeasonState extends Fake implements SelectedSeasonState {}

class MockWatchlistTvSeriesStatusState extends Fake
    implements WatchlistTvSeriesStatusState {}

class MockTvSeriesRecommendationsState extends Fake
    implements TvSeriesRecommendationsState {}

class MockWatchlistTvSeriesState extends Fake
    implements WatchlistTvSeriesState {}

class MockEpisodesState extends Fake implements EpisodesState {}

void main() {
  late MockTvSeriesDetailBloc mockTvSeriesDetailBloc;
  late MockTvSeriesRecommendationsBloc mockTvSeriesRecommendationsBloc;
  late MockWatchlistTvSeriesBloc mockWatchlistTvSeriesBloc;
  late MockWatchlistTvSeriesStatusBloc mockWatchlistTvSeriesStatusBloc;
  late MockSelectedSeasonBloc mockSelectedSeasonBloc;
  late MockEpisodesBloc mockEpisodesBloc;

  setUpAll(() {
    registerFallbackValue(MockTvSeriesDetailState());
    registerFallbackValue(MockTvSeriesDetailEvent());
    registerFallbackValue(MockTvSeriesRecommendationsState());
    registerFallbackValue(MockTvSeriesRecommendationsEvent());
    registerFallbackValue(MockWatchlistTvSeriesState());
    registerFallbackValue(MockWatchlistTvSeriesEvent());
    registerFallbackValue(MockWatchlistTvSeriesStatusState());
    registerFallbackValue(MockWatchlistTvSeriesStatusEvent());
    registerFallbackValue(MockSelectedSeasonState());
    registerFallbackValue(MockSelectedSeasonEvent());
    registerFallbackValue(MockEpisodesState());
    registerFallbackValue(MockEpisodesEvent());
  });

  setUp(() {
    mockTvSeriesDetailBloc = MockTvSeriesDetailBloc();
    mockTvSeriesRecommendationsBloc = MockTvSeriesRecommendationsBloc();
    mockWatchlistTvSeriesBloc = MockWatchlistTvSeriesBloc();
    mockWatchlistTvSeriesStatusBloc = MockWatchlistTvSeriesStatusBloc();
    mockSelectedSeasonBloc = MockSelectedSeasonBloc();
    mockEpisodesBloc = MockEpisodesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<TvSeriesDetailBloc>(
          create: (_) => mockTvSeriesDetailBloc,
        ),
        BlocProvider<TvSeriesRecommendationsBloc>(
          create: (_) => mockTvSeriesRecommendationsBloc,
        ),
        BlocProvider<WatchlistTvSeriesBloc>(
          create: (_) => mockWatchlistTvSeriesBloc,
        ),
        BlocProvider<WatchlistTvSeriesStatusBloc>(
          create: (_) => mockWatchlistTvSeriesStatusBloc,
        ),
        BlocProvider<SelectedSeasonBloc>(
          create: (_) => mockSelectedSeasonBloc,
        ),
        BlocProvider<EpisodesBloc>(
          create: (_) => mockEpisodesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    mockTvSeriesDetailBloc.close();
    mockTvSeriesRecommendationsBloc.close();
    mockWatchlistTvSeriesBloc.close();
    mockWatchlistTvSeriesStatusBloc.close();
    mockSelectedSeasonBloc.close();
    mockEpisodesBloc.close();
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.add(FetchTvSeriesDetail(1)))
        .thenAnswer((_) async => {});
    when(() => mockTvSeriesRecommendationsBloc.add(FetchRecommendations(1)))
        .thenAnswer((_) async => {});
    when(() => mockTvSeriesDetailBloc.state)
        .thenAnswer((_) => TvSeriesDetailHasData(testSeriesDetail));
    when(() => mockTvSeriesRecommendationsBloc.state)
        .thenAnswer((_) => TvSeriesRecommendationsHasData(<Tv>[]));
    when(() => mockWatchlistTvSeriesStatusBloc.add(LoadWatchlistStatus(1)))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistTvSeriesStatusBloc.state)
        .thenAnswer((_) => IsNotWatchlistTvSeries());
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenAnswer((_) => WatchlistTvSeriesInitial());
    when(() => mockSelectedSeasonBloc.add(SelectedSeason(1)))
        .thenAnswer((_) async => {});
    when(() => mockSelectedSeasonBloc.state)
        .thenAnswer((_) => SelectedSeasonHasData(1));
    when(() => mockEpisodesBloc.add(FetchEpisodes(1, 1)))
        .thenAnswer((_) async => {});
    when(() => mockEpisodesBloc.state)
        .thenAnswer((_) => EpisodeHasData([testEpisode]));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.add(FetchTvSeriesDetail(1)))
        .thenAnswer((_) async => {});
    when(() => mockTvSeriesRecommendationsBloc.add(FetchRecommendations(1)))
        .thenAnswer((_) async => {});
    when(() => mockTvSeriesDetailBloc.state)
        .thenAnswer((_) => TvSeriesDetailHasData(testSeriesDetail));
    when(() => mockTvSeriesRecommendationsBloc.state)
        .thenAnswer((_) => TvSeriesRecommendationsHasData(<Tv>[]));
    when(() => mockWatchlistTvSeriesStatusBloc.add(LoadWatchlistStatus(1)))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistTvSeriesStatusBloc.state)
        .thenAnswer((_) => IsWatchlistTvSeries());
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenAnswer((_) => WatchlistTvSeriesInitial());
    when(() => mockSelectedSeasonBloc.add(SelectedSeason(1)))
        .thenAnswer((_) async => {});
    when(() => mockSelectedSeasonBloc.state)
        .thenAnswer((_) => SelectedSeasonHasData(1));
    when(() => mockEpisodesBloc.add(FetchEpisodes(1, 1)))
        .thenAnswer((_) async => {});
    when(() => mockEpisodesBloc.state)
        .thenAnswer((_) => EpisodeHasData([testEpisode]));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.add(FetchTvSeriesDetail(1)))
        .thenAnswer((_) async => {});
    when(() => mockTvSeriesRecommendationsBloc.add(FetchRecommendations(1)))
        .thenAnswer((_) async => {});
    when(() => mockTvSeriesDetailBloc.state)
        .thenAnswer((_) => TvSeriesDetailHasData(testSeriesDetail));
    when(() => mockTvSeriesRecommendationsBloc.state)
        .thenAnswer((_) => TvSeriesRecommendationsHasData(<Tv>[]));
    when(() => mockWatchlistTvSeriesStatusBloc.add(LoadWatchlistStatus(1)))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistTvSeriesStatusBloc.state)
        .thenAnswer((_) => IsNotWatchlistTvSeries());
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenAnswer((_) => WatchlistTvSeriesInitial());
    when(() => mockSelectedSeasonBloc.add(SelectedSeason(1)))
        .thenAnswer((_) async => {});
    when(() => mockSelectedSeasonBloc.state)
        .thenAnswer((_) => SelectedSeasonHasData(1));
    when(() => mockEpisodesBloc.add(FetchEpisodes(1, 1)))
        .thenAnswer((_) async => {});
    when(() => mockEpisodesBloc.state)
        .thenAnswer((_) => EpisodeHasData([testEpisode]));
    whenListen(mockWatchlistTvSeriesBloc,
        Stream.fromIterable([WatchlistTvSeriesAdded('Added to Watchlist')]));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.add(FetchTvSeriesDetail(1)))
        .thenAnswer((_) async => {});
    when(() => mockTvSeriesRecommendationsBloc.add(FetchRecommendations(1)))
        .thenAnswer((_) async => {});
    when(() => mockTvSeriesDetailBloc.state)
        .thenAnswer((_) => TvSeriesDetailHasData(testSeriesDetail));
    when(() => mockTvSeriesRecommendationsBloc.state)
        .thenAnswer((_) => TvSeriesRecommendationsHasData(<Tv>[]));
    when(() => mockWatchlistTvSeriesStatusBloc.add(LoadWatchlistStatus(1)))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistTvSeriesStatusBloc.state)
        .thenAnswer((_) => IsNotWatchlistTvSeries());
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenAnswer((_) => WatchlistTvSeriesInitial());
    when(() => mockSelectedSeasonBloc.add(SelectedSeason(1)))
        .thenAnswer((_) async => {});
    when(() => mockSelectedSeasonBloc.state)
        .thenAnswer((_) => SelectedSeasonHasData(1));
    when(() => mockEpisodesBloc.add(FetchEpisodes(1, 1)))
        .thenAnswer((_) async => {});
    when(() => mockEpisodesBloc.state)
        .thenAnswer((_) => EpisodeHasData([testEpisode]));
    whenListen(mockWatchlistTvSeriesBloc,
        Stream.fromIterable([WatchlistTvSeriesError('Failed')]));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
