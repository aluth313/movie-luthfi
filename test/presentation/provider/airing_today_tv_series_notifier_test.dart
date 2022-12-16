import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tv_series.dart';
import 'package:ditonton/presentation/provider/airing_today_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'airing_today_tv_series_notifier_test.mocks.dart';

@GenerateMocks([GetAiringTodaySeries])
void main() {
  late MockGetAiringTodaySeries mockGetAiringTodaySeries;
  late AiringTodaySeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetAiringTodaySeries = MockGetAiringTodaySeries();
    notifier = AiringTodaySeriesNotifier(
        getAiringTodaySeries: mockGetAiringTodaySeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

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

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetAiringTodaySeries.execute())
        .thenAnswer((_) async => Right(tSeriesList));
    // act
    notifier.fetchAiringTodaySeries();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change series data when data is gotten successfully', () async {
    // arrange
    when(mockGetAiringTodaySeries.execute())
        .thenAnswer((_) async => Right(tSeriesList));
    // act
    await notifier.fetchAiringTodaySeries();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.series, tSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetAiringTodaySeries.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchAiringTodaySeries();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
