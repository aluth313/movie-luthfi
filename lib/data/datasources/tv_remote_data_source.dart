import 'dart:convert';

import 'package:ditonton/data/models/episode_response.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:http/http.dart' as http;

abstract class TvRemoteDataSource {
  Future<List<TVModel>> getPopularTVSeries();
  Future<TvSeriesDetailResponse> getTvSeriesDetail(int id);
  Future<List<TVModel>> getTvSeriesRecommendations(int id);
  Future<EpisodeResponse> getEpisodesBySessionNumber(int tvId, int sessionNumber);
  // Future<List<MovieModel>> searchMovies(String query);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TvRemoteDataSourceImpl({required this.client});

  @override
  Future<TvSeriesDetailResponse> getTvSeriesDetail(int id) async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  // @override
  // Future<List<MovieModel>> searchMovies(String query) async {
  //   final response = await client
  //       .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$query'));

  //   if (response.statusCode == 200) {
  //     return MovieResponse.fromJson(json.decode(response.body)).movieList;
  //   } else {
  //     throw ServerException();
  //   }
  // }

  @override
  Future<List<TVModel>> getPopularTVSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }
  
  @override
  Future<List<TVModel>> getTvSeriesRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }
  
  @override
  Future<EpisodeResponse> getEpisodesBySessionNumber(int tvId, int sessionNumber) async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/$tvId/season/$sessionNumber?$API_KEY'));

    if (response.statusCode == 200) {
      return EpisodeResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
