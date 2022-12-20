import 'dart:convert';

import 'package:series/data/models/tv_model.dart';
import 'package:series/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tSeriesModel = TVModel(
    backdropPath: '/hIZFG7MK4leU4axRFKJWqrjhmxZ.jpg',
    genreIds: [10765, 18],
    id: 95403,
    originalName: 'The Peripheral',
    overview: 'Stuck in a small Appalachian town',
    popularity: 1675.293,
    posterPath: '/ccBe5BVeibdBEQU7l6P6BubajWV.jpg',
    firstAirDate: '2022-10-20',
    name: 'The Peripheral',
    voteAverage: 8.3,
    voteCount: 274,
    originCountry: ['US'],
    originalLanguage: 'en',
  );
  final tSeriesResponseModel = TvResponse(tvList: <TVModel>[tSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/airing_today.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/hIZFG7MK4leU4axRFKJWqrjhmxZ.jpg",
            "first_air_date": "2022-10-20",
            "genre_ids": [10765, 18],
            "id": 95403,
            "name": "The Peripheral",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "The Peripheral",
            "overview": "Stuck in a small Appalachian town",
            "popularity": 1675.293,
            "poster_path": "/ccBe5BVeibdBEQU7l6P6BubajWV.jpg",
            "vote_average": 8.3,
            "vote_count": 274
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
