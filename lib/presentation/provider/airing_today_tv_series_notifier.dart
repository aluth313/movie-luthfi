import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tv_series.dart';
import 'package:flutter/foundation.dart';

class AiringTodaySeriesNotifier extends ChangeNotifier {
  final GetAiringTodaySeries getAiringTodaySeries;

  AiringTodaySeriesNotifier({required this.getAiringTodaySeries});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _series = [];
  List<Tv> get series => _series;

  String _message = '';
  String get message => _message;

  Future<void> fetchAiringTodaySeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getAiringTodaySeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (seriesData) {
        _series = seriesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
