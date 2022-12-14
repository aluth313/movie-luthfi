part of 'watchlist_tv_series_status_bloc.dart';

abstract class WatchlistTvSeriesStatusEvent extends Equatable {
  const WatchlistTvSeriesStatusEvent();

  @override
  List<Object> get props => [];
}

class LoadWatchlistStatus extends WatchlistTvSeriesStatusEvent {
  final int id;

  LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
