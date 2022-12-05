import 'dart:convert';
import 'dart:io';

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/episode_response.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

abstract class TvRemoteDataSource {
  Future<List<TVModel>> getPopularTVSeries();
  Future<TvSeriesDetailResponse> getTvSeriesDetail(int id);
  Future<List<TVModel>> getTvSeriesRecommendations(int id);
  Future<List<EpisodeModel>> getEpisodesBySessionNumber(
      int tvId, int sessionNumber);
  Future<List<TVModel>> getTopRatedSeries();
  Future<List<TVModel>> getAiringTodaySeries();
  Future<List<TVModel>> searchSeries(String query);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  final http.Client client;

  TvRemoteDataSourceImpl({required this.client});

  @override
  Future<TvSeriesDetailResponse> getTvSeriesDetail(int id) async {
    HttpClient httpClient = HttpClient(context: await globalContext);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(httpClient);
    final response = await ioClient.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getAiringTodaySeries() async {
    HttpClient httpClient = HttpClient(context: await globalContext);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(httpClient);
    final response =
        await ioClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getTopRatedSeries() async {
    HttpClient httpClient = HttpClient(context: await globalContext);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(httpClient);
    final response =
        await ioClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> searchSeries(String query) async {
    HttpClient httpClient = HttpClient(context: await globalContext);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(httpClient);
    final response = await ioClient
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getPopularTVSeries() async {
    HttpClient httpClient = HttpClient(context: await globalContext);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(httpClient);
    final response =
        await ioClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getTvSeriesRecommendations(int id) async {
    HttpClient httpClient = HttpClient(context: await globalContext);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(httpClient);
    final response = await ioClient
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<EpisodeModel>> getEpisodesBySessionNumber(
      int tvId, int sessionNumber) async {
    HttpClient httpClient = HttpClient(context: await globalContext);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(httpClient);
    final response = await ioClient
        .get(Uri.parse('$BASE_URL/tv/$tvId/season/$sessionNumber?$API_KEY'));

    if (response.statusCode == 200) {
      return EpisodeResponse.fromJson(json.decode(response.body)).episodes;
    } else {
      throw ServerException();
    }
  }
}
