import 'package:dartz/dartz.dart';
import 'package:series/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../test/dummy_data/dummy_objects.dart';
import '../../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistSeries usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = RemoveWatchlistSeries(mockTvRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockTvRepository.removeWatchlist(testSeriesDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testSeriesDetail);
    // assert
    verify(mockTvRepository.removeWatchlist(testSeriesDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
