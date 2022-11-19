import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/episodes.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_episodes.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;
  final GetEpisodes getEpisodes;
  final GetWatchListTvSeriesStatus getWatchListStatus;
  final SaveWatchlistTvSeries saveWatchlist;
  // final RemoveWatchlist removeWatchlist;

  TvSeriesDetailNotifier({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendations,
    required this.getEpisodes,
    required this.saveWatchlist,
    required this.getWatchListStatus,
    // required this.removeWatchlist,
  });

  late TvDetail _series;
  TvDetail get series => _series;

  RequestState _tvSeriesState = RequestState.Empty;
  RequestState get tvSeriesState => _tvSeriesState;

  List<Tv> _seriesRecommendations = [];
  List<Tv> get tvSeriesRecommendations => _seriesRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  late Episodes _episodes;
  Episodes get episodes => _episodes;

  RequestState _episodeState = RequestState.Empty;
  RequestState get episodeState => _episodeState;

  late int _selectedSessionId;
  int get selectedSessionId => _selectedSessionId;

  RequestState _selectedSeasonIdState = RequestState.Empty;
  RequestState get selectedSeasonIdState => _selectedSeasonIdState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTvSeriesDetail(int id) async {
    _tvSeriesState = RequestState.Loading;
    _selectedSeasonIdState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvSeriesDetail.execute(id);
    final recommendationResult = await getTvSeriesRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _tvSeriesState = RequestState.Error;
        _selectedSeasonIdState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (series) async {
        _recommendationState = RequestState.Loading;
        _series = series;
        if (series.seasons != null && series.seasons!.length > 0) {
          _selectedSessionId = series.seasons![0].seasonNumber;
          _episodeState = RequestState.Loading;
          final episodeResult = await getEpisodes.execute(
            id,
            series.seasons![0].seasonNumber,
          );
          episodeResult.fold((failure) {
            _episodeState = RequestState.Error;
            _message = failure.message;
            notifyListeners();
          }, (episodes) {
            _episodes = episodes;
            _episodeState = RequestState.Loaded;
            notifyListeners();
          });
        }
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (recommendationSeries) {
            _recommendationState = RequestState.Loaded;
            _seriesRecommendations = recommendationSeries;
          },
        );
        _tvSeriesState = RequestState.Loaded;
        _selectedSeasonIdState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchEpisodesBySessionNumber(int tvId, int seasonNumber) async {
    _episodeState = RequestState.Loading;
    _selectedSessionId = seasonNumber;
    notifyListeners();
    final episodeResult = await getEpisodes.execute(tvId, seasonNumber);
    episodeResult.fold(
      (failure) {
        _episodeState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (episodes) {
        _episodes = episodes;
        _episodeState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvDetail series) async {
    final result = await saveWatchlist.execute(series);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(series.id);
  }

  // Future<void> removeFromWatchlist(TvDetail movie) async {
  //   final result = await removeWatchlist.execute(movie);

  //   await result.fold(
  //     (failure) async {
  //       _watchlistMessage = failure.message;
  //     },
  //     (successMessage) async {
  //       _watchlistMessage = successMessage;
  //     },
  //   );

  //   await loadWatchlistStatus(movie.id);
  // }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
