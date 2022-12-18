import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:series/domain/usecases/get_tv_series_detail.dart';
import 'package:series/presentation/bloc/tv_series_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail])
void main() {
  late TvSeriesDetailBloc tvSeriesDetailBloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;

  setUp(
    () {
      mockGetTvSeriesDetail = MockGetTvSeriesDetail();
      tvSeriesDetailBloc = TvSeriesDetailBloc(mockGetTvSeriesDetail);
    },
  );

  test(
    'initial state should be empty',
    () {
      expect(tvSeriesDetailBloc.state, TvSeriesDetailEmpty());
    },
  );

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvSeriesDetail.execute(1))
          .thenAnswer((_) async => Right(testSeriesDetail));
      return tvSeriesDetailBloc;
    },
    act: (bloc) => bloc.add(FetchTvSeriesDetail(1)),
    expect: () => [
      TvSeriesDetailLoading(),
      TvSeriesDetailHasData(testSeriesDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesDetail.execute(1));
    },
  );

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    'Should emit [Loading, Error] when data is gotten unsuccessful',
    build: () {
      when(mockGetTvSeriesDetail.execute(1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesDetailBloc;
    },
    act: (bloc) => bloc.add(FetchTvSeriesDetail(1)),
    expect: () => [
      TvSeriesDetailLoading(),
      TvSeriesDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesDetail.execute(1));
    },
  );
}
