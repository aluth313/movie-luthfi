import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_episodes.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_notifier_test.mocks.dart';
import 'tv_series_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  GetTvSeriesRecommendations,
  GetWatchListTvSeriesStatus,
  SaveWatchlistTvSeries,
  RemoveWatchlistSeries,
  GetEpisodes,
])
void main() {
  late TvSeriesDetailNotifier provider;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late MockGetWatchListTvSeriesStatus mockGetWatchlistTvSeriesStatus;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistSeries mockRemoveWatchlistSeries;
  late MockGetEpisodes mockGetEpisodes;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    mockGetWatchlistTvSeriesStatus = MockGetWatchListTvSeriesStatus();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistSeries = MockRemoveWatchlistSeries();
    mockGetEpisodes = MockGetEpisodes();
    provider = TvSeriesDetailNotifier(
      getTvSeriesDetail: mockGetTvSeriesDetail,
      getTvSeriesRecommendations: mockGetTvSeriesRecommendations,
      getWatchListStatus: mockGetWatchlistTvSeriesStatus,
      saveWatchlist: mockSaveWatchlistTvSeries,
      removeWatchlist: mockRemoveWatchlistSeries,
      getEpisodes: mockGetEpisodes,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 31917;
  final seasonNumber = 1;

  final tSeries = Tv(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
    originCountry: ['originCountry'],
    originalLanguage: 'originalLanguage',
  );
  final tSeriesList = <Tv>[tSeries];

  final tEpisode = Episode(
    episodeNumber: 1,
    runtime: 1,
    stillPath: 'stillPath',
    overview: 'overview',
  );

  final tEpisodes = <Episode>[tEpisode];

  void _arrangeUsecase() {
    when(mockGetTvSeriesDetail.execute(tId))
        .thenAnswer((_) async => Right(testSeriesDetail));
    when(mockGetTvSeriesRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tSeriesList));
    when(mockGetEpisodes.execute(tId, seasonNumber))
        .thenAnswer((_) async => Right(tEpisodes));
  }

  group('Get Series Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      verify(mockGetTvSeriesDetail.execute(tId));
      verify(mockGetTvSeriesRecommendations.execute(tId));
      verify(mockGetEpisodes.execute(tId, seasonNumber));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    // test('should change series when data is gotten successfully', () {
    //   // arrange
    //   _arrangeUsecase();
    //   // act
    //   provider.fetchTvSeriesDetail(tId);
    //   // assert
    //   expect(provider.tvSeriesState, RequestState.Loaded);
    //   expect(provider.series, testSeriesDetail);
    //   expect(listenerCallCount, 3);
    // });

    // test('should change recommendation series when data is gotten successfully',
    //     () async {
    //   // arrange
    //   _arrangeUsecase();
    //   // act
    //   await provider.fetchTvSeriesDetail(tId);
    //   // assert
    //   expect(provider.tvSeriesState, RequestState.Loaded);
    //   expect(provider.tvSeriesRecommendations, tSeriesList);
    // });
  });

  group('Get Episodes', () {
    test('should get episodes by season number & series id', () async {
      _arrangeUsecase();
      // act
      await provider.fetchEpisodesBySessionNumber(tId, seasonNumber);
      // assert
      verify(mockGetEpisodes.execute(tId, seasonNumber));
    });
  });

  // group('Get Series Recommendations', () {
  //   test('should get data from the usecase', () async {
  //     // arrange
  //     _arrangeUsecase();
  //     // act
  //     await provider.fetchTvSeriesDetail(tId);
  //     // assert
  //     verify(mockGetTvSeriesRecommendations.execute(tId));
  //     expect(provider.tvSeriesRecommendations, tSeriesList);
  //   });

  //   test('should update recommendation state when data is gotten successfully',
  //       () async {
  //     // arrange
  //     _arrangeUsecase();
  //     // act
  //     await provider.fetchTvSeriesDetail(tId);
  //     // assert
  //     expect(provider.recommendationState, RequestState.Loaded);
  //     expect(provider.tvSeriesRecommendations, tSeriesList);
  //   });

  //   test('should update error message when request in successful', () async {
  //     // arrange
  //     when(mockGetTvSeriesDetail.execute(tId))
  //         .thenAnswer((_) async => Right(testSeriesDetail));
  //     when(mockGetTvSeriesRecommendations.execute(tId))
  //         .thenAnswer((_) async => Left(ServerFailure('Failed')));
  //     when(mockGetEpisodes.execute(tId, seasonNumber))
  //         .thenAnswer((_) async => Right(tEpisodes));
  //     // act
  //     await provider.fetchTvSeriesDetail(tId);
  //     // assert
  //     expect(provider.recommendationState, RequestState.Error);
  //     expect(provider.message, 'Failed');
  //   });
  // });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistTvSeriesStatus.execute(1))
          .thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlistTvSeries.execute(testSeriesDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistTvSeriesStatus.execute(testSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testSeriesDetail);
      // assert
      verify(mockSaveWatchlistTvSeries.execute(testSeriesDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlistSeries.execute(testSeriesDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistTvSeriesStatus.execute(testSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testSeriesDetail);
      // assert
      verify(mockRemoveWatchlistSeries.execute(testSeriesDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlistTvSeries.execute(testSeriesDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistTvSeriesStatus.execute(testSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testSeriesDetail);
      // assert
      verify(mockGetWatchlistTvSeriesStatus.execute(testSeriesDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlistTvSeries.execute(testSeriesDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistTvSeriesStatus.execute(testSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testSeriesDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvSeriesDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
