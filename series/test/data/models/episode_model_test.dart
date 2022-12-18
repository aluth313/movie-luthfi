import 'package:series/data/models/episode_model.dart';
import 'package:series/domain/entities/episode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tEpisodeModel = EpisodeModel(
      overview: 'overview',
      episodeNumber: 1,
      runtime: 1,
      stillPath: 'stillPath');

  final tEpisode = Episode(
      overview: 'overview',
      episodeNumber: 1,
      runtime: 1,
      stillPath: 'stillPath');

  test('should be a subclass of Episode entity', () async {
    final result = tEpisodeModel.toEntity();
    expect(result, tEpisode);
  });
}
