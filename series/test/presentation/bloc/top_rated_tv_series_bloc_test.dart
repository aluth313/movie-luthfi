import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:series/domain/usecases/get_top_rated_tv_series.dart';
import 'package:series/presentation/bloc/top_rated_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test/dummy_data/dummy_objects.dart';
import 'top_rated_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedSeries])
void main() {
  late TopRatedTvSeriesBloc topRatedTvSeriesBloc;
  late MockGetTopRatedSeries mockGetTopRatedSeries;

  setUp(
    () {
      mockGetTopRatedSeries = MockGetTopRatedSeries();
      topRatedTvSeriesBloc = TopRatedTvSeriesBloc(mockGetTopRatedSeries);
    },
  );

  test(
    'initial state should be empty',
    () {
      expect(topRatedTvSeriesBloc.state, TopRatedTvSeriesEmpty());
    },
  );

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Right(testSeriesList));
      return topRatedTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedSeries()),
    expect: () => [
      TopRatedTvSeriesLoading(),
      TopRatedTvSeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedSeries.execute());
    },
  );

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    'Should emit [Loading, Error] when data is gotten unsuccessful',
    build: () {
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedSeries()),
    expect: () => [
      TopRatedTvSeriesLoading(),
      TopRatedTvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedSeries.execute());
    },
  );
}
