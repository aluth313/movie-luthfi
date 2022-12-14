import 'package:dartz/dartz.dart';
import 'package:series/domain/entities/tv.dart';
import 'package:series/domain/usecases/get_top_rated_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedSeries usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTopRatedSeries(mockTvRepository);
  });

  final tSeries = <Tv>[];

  test('should get list of series from repository', () async {
    // arrange
    when(mockTvRepository.getTopRatedSeries())
        .thenAnswer((_) async => Right(tSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tSeries));
  });
}
