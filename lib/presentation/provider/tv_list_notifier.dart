import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:flutter/material.dart';

class TvListNotifier extends ChangeNotifier {
  var _popularTv = <Tv>[];
  List<Tv> get popularTv => _popularTv;

  RequestState _popularTvState = RequestState.Empty;
  RequestState get popularTvState => _popularTvState;

  var _topRatedSeries = <Tv>[];
  List<Tv> get topRatedSeries => _topRatedSeries;

  RequestState _topRatedSeriesState = RequestState.Empty;
  RequestState get topRatedSeriesState => _topRatedSeriesState;

  String _message = '';
  String get message => _message;

  TvListNotifier({
    required this.getPopularTv,
    required this.getTopRatedSeries,
  });

  final GetPopularTv getPopularTv;
  final GetTopRatedSeries getTopRatedSeries;

  Future<void> fetchPopularTv() async {
    _popularTvState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTv.execute();
    result.fold(
      (failure) {
        _popularTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _popularTvState = RequestState.Loaded;
        _popularTv = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedSeries() async {
    _topRatedSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedSeries.execute();
    result.fold(
      (failure) {
        _topRatedSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (seriesData) {
        _topRatedSeriesState = RequestState.Loaded;
        _topRatedSeries = seriesData;
        notifyListeners();
      },
    );
  }
}
