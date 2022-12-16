import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/usecases/get_episodes.dart';
import 'package:ditonton/presentation/bloc/episodes_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../provider/tv_series_detail_notifier_test.mocks.dart';

@GenerateMocks([GetEpisodes])
void main() {
  late EpisodesBloc episodesBloc;
  late MockGetEpisodes mockGetEMockGetEpisodes;

  setUp(
    () {
      mockGetEMockGetEpisodes = MockGetEpisodes();
      episodesBloc = EpisodesBloc(mockGetEMockGetEpisodes);
    },
  );

  final testEpisode = Episode(
    episodeNumber: 1,
    runtime: 66,
    stillPath: '/1JupR6vLoYYJb1ySERUCZ3k1qJW.jpg',
    overview:
        'Inside Lee Byeong-chan\'s science lab, a student incurs a seemingly harmless bite. Shortly after, a fast-spreading outbreak soaks the school in blood.',
  );

  final testEpisodeList = [testEpisode];

  test(
    'initial state should be empty',
    () {
      expect(episodesBloc.state, EpisodeEmpty());
    },
  );

  blocTest<EpisodesBloc, EpisodesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetEMockGetEpisodes.execute(1, 1))
          .thenAnswer((_) async => Right(testEpisodeList));
      return episodesBloc;
    },
    act: (bloc) => bloc.add(FetchEpisodes(1, 1)),
    expect: () => [
      EpisodeLoading(),
      EpisodeHasData(testEpisodeList),
    ],
    verify: (bloc) {
      verify(mockGetEMockGetEpisodes.execute(1, 1));
    },
  );

  blocTest<EpisodesBloc, EpisodesState>(
    'Should emit [Loading, Error] when data is gotten unsuccessful',
    build: () {
      when(mockGetEMockGetEpisodes.execute(1, 1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return episodesBloc;
    },
    act: (bloc) => bloc.add(FetchEpisodes(1, 1)),
    expect: () => [
      EpisodeLoading(),
      EpisodeError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetEMockGetEpisodes.execute(1, 1));
    },
  );
}
