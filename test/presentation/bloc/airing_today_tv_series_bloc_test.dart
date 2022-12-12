import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tv_series.dart';
import 'package:ditonton/presentation/bloc/airing_today_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../provider/tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetAiringTodaySeries])
void main() {
  late AiringTodayTvSeriesBloc airingTodayTvSeriesBloc;
  late MockGetAiringTodaySeries mockGetAiringTodaySeries;

  setUp(
    () {
      mockGetAiringTodaySeries = MockGetAiringTodaySeries();
      airingTodayTvSeriesBloc =
          AiringTodayTvSeriesBloc(mockGetAiringTodaySeries);
    },
  );

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

  test(
    'initial state should be empty',
    () {
      expect(airingTodayTvSeriesBloc.state, AiringTodayTvSeriesEmpty());
    },
  );

  blocTest<AiringTodayTvSeriesBloc, AiringTodayTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetAiringTodaySeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      return airingTodayTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchAiringTodaySeries()),
    expect: () => [
      AiringTodayTvSeriesLoading(),
      AiringTodayTvSeriesHasData(tSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetAiringTodaySeries.execute());
    },
  );

  blocTest<AiringTodayTvSeriesBloc, AiringTodayTvSeriesState>(
    'Should emit [Loading, Error] when data is gotten unsuccessful',
    build: () {
      when(mockGetAiringTodaySeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return airingTodayTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchAiringTodaySeries()),
    expect: () => [
      AiringTodayTvSeriesLoading(),
      AiringTodayTvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetAiringTodaySeries.execute());
    },
  );
}
