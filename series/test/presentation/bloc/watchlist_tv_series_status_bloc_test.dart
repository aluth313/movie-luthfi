import 'package:bloc_test/bloc_test.dart';
import 'package:series/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:series/presentation/bloc/watchlist_tv_series_status_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_tv_series_status_bloc_test.mocks.dart';

@GenerateMocks([GetWatchListTvSeriesStatus])
void main() {
  late WatchlistTvSeriesStatusBloc watchlistTvSeriesStatusBloc;
  late MockGetWatchListTvSeriesStatus mockGetWatchListTvSeriesStatus;

  setUp(
    () {
      mockGetWatchListTvSeriesStatus = MockGetWatchListTvSeriesStatus();
      watchlistTvSeriesStatusBloc =
          WatchlistTvSeriesStatusBloc(mockGetWatchListTvSeriesStatus);
    },
  );

  test(
    'initial state should be not watchlist',
    () {
      expect(watchlistTvSeriesStatusBloc.state, IsNotWatchlistTvSeries());
    },
  );

  blocTest<WatchlistTvSeriesStatusBloc, WatchlistTvSeriesStatusState>(
    'Should emit [IsWatchlistTvSeries] when data is gotten successfully',
    build: () {
      when(mockGetWatchListTvSeriesStatus.execute(1))
          .thenAnswer((_) async => true);
      return watchlistTvSeriesStatusBloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistStatus(1)),
    expect: () => [
      IsWatchlistTvSeries(),
    ],
    verify: (bloc) {
      verify(mockGetWatchListTvSeriesStatus.execute(1));
    },
  );

  blocTest<WatchlistTvSeriesStatusBloc, WatchlistTvSeriesStatusState>(
    'Should emit [IsNotWatchlistTvSeries] when data is gotten unsuccessful',
    build: () {
      when(mockGetWatchListTvSeriesStatus.execute(1))
          .thenAnswer((_) async => false);
      return watchlistTvSeriesStatusBloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistStatus(1)),
    expect: () => [
      IsNotWatchlistTvSeries(),
    ],
    verify: (bloc) {
      verify(mockGetWatchListTvSeriesStatus.execute(1));
    },
  );
}
