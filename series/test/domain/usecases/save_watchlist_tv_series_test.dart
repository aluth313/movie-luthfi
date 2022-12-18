import 'package:dartz/dartz.dart';
import 'package:series/domain/usecases/save_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../test/dummy_data/dummy_objects.dart';
import '../../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTvSeries usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SaveWatchlistTvSeries(mockTvRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockTvRepository.saveWatchlist(testSeriesDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testSeriesDetail);
    // assert
    verify(mockTvRepository.saveWatchlist(testSeriesDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
