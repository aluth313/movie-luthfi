import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchSeries usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SearchSeries(mockTvRepository);
  });

  final tSeries = <Tv>[];
  final tQuery = 'Chucky';

  test('should get list of series from the repository', () async {
    // arrange
    when(mockTvRepository.searchSeries(tQuery))
        .thenAnswer((_) async => Right(tSeries));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tSeries));
  });
}
