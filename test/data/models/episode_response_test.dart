import 'dart:convert';

import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/episode_response.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tEpisodeModel = EpisodeModel(
    overview: 'overview',
    episodeNumber: 1,
    runtime: 1,
    stillPath: 'stillPath',
  );

  final tEpisode = Episode(
    overview: 'overview',
    episodeNumber: 1,
    runtime: 1,
    stillPath: 'stillPath',
  );

  final tEpisodeResponseModel =
      EpisodeResponse(episodes: <EpisodeModel>[tEpisodeModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/episodes.json'));
      // act
      final result = EpisodeResponse.fromJson(jsonMap);
      // assert
      expect(result, tEpisodeResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tEpisodeResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "episodes": [
          {
            "episode_number": 1,
            "overview": "overview",
            "runtime": 1,
            "still_path": "stillPath",
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
