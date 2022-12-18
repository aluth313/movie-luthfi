import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:series/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:series/domain/usecases/save_watchlist_tv_series.dart';
import 'package:series/presentation/bloc/watchlist_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks([SaveWatchlistTvSeries, RemoveWatchlistSeries])
void main() {
  late WatchlistTvSeriesBloc watchlistTvSeriesBloc;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistSeries mockRemoveWatchlistSeries;

  setUp(
    () {
      mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
      mockRemoveWatchlistSeries = MockRemoveWatchlistSeries();
      watchlistTvSeriesBloc = WatchlistTvSeriesBloc(
        saveWatchlist: mockSaveWatchlistTvSeries,
        removeWatchlist: mockRemoveWatchlistSeries,
      );
    },
  );

  test(
    'initial state should be WatchlistTvSeriesInitial',
    () {
      expect(watchlistTvSeriesBloc.state, WatchlistTvSeriesInitial());
    },
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [WatchlistTvSeriesAdded] when data is added successfully',
    build: () {
      when(mockSaveWatchlistTvSeries.execute(testSeriesDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(AddWatchlist(testSeriesDetail)),
    expect: () => [
      WatchlistTvSeriesInitial(),
      WatchlistTvSeriesAdded('Added to Watchlist'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistTvSeries.execute(testSeriesDetail));
    },
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [WatchlistTvSeriesError] when data is added unsuccessfull',
    build: () {
      when(mockSaveWatchlistTvSeries.execute(testSeriesDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(AddWatchlist(testSeriesDetail)),
    expect: () => [
      WatchlistTvSeriesInitial(),
      WatchlistTvSeriesError('Failed'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistTvSeries.execute(testSeriesDetail));
    },
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [WatchlistTvSeriesRemoved] when data is removed successfully',
    build: () {
      when(mockRemoveWatchlistSeries.execute(testSeriesDetail))
          .thenAnswer((_) async => Right('Removed from Watchlist'));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchlist(testSeriesDetail)),
    expect: () => [
      WatchlistTvSeriesInitial(),
      WatchlistTvSeriesRemoved('Removed from Watchlist'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistSeries.execute(testSeriesDetail));
    },
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [WatchlistTvSeriesError] when data is removed unsuccessfull',
    build: () {
      when(mockRemoveWatchlistSeries.execute(testSeriesDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchlist(testSeriesDetail)),
    expect: () => [
      WatchlistTvSeriesInitial(),
      WatchlistTvSeriesError('Failed'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistSeries.execute(testSeriesDetail));
    },
  );
}
