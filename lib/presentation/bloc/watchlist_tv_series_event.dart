part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTvSeriesEvent extends Equatable {
  const WatchlistTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class AddWatchlist extends WatchlistTvSeriesEvent {
  final TvDetail series;

  AddWatchlist(this.series);

  @override
  List<Object> get props => [series];
}

class RemoveFromWatchlist extends WatchlistTvSeriesEvent {
  final TvDetail series;

  RemoveFromWatchlist(this.series);

  @override
  List<Object> get props => [series];
}

class LoadWatchlistStatus extends WatchlistTvSeriesEvent {
  final int id;

  LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
