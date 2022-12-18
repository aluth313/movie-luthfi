import 'package:dartz/dartz.dart';
import 'package:series/domain/entities/episode.dart';
import 'package:series/domain/usecases/get_episodes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late GetEpisodes usecase;
  late MockTvRepository mockTvRpository;

  setUp(() {
    mockTvRpository = MockTvRepository();
    usecase = GetEpisodes(mockTvRpository);
  });

  final tEpisodes = <Episode>[];

  group('GetEpisodes Tests', () {
    group('execute', () {
      test(
          'should get list of episodes from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvRpository.getEpisodesBySessionNumber(1, 1))
            .thenAnswer((_) async => Right(tEpisodes));
        // act
        final result = await usecase.execute(1, 1);
        // assert
        expect(result, Right(tEpisodes));
      });
    });
  });
}
