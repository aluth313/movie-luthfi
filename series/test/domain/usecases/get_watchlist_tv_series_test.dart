import 'package:dartz/dartz.dart';
import 'package:series/domain/usecases/get_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../test/dummy_data/dummy_objects.dart';
import '../../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistSeries usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetWatchlistSeries(mockTvRepository);
  });

  test('should get list of series from the repository', () async {
    // arrange
    when(mockTvRepository.getWatchlistSeries())
        .thenAnswer((_) async => Right(testSeriesList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testSeriesList));
  });
}
