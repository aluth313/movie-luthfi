part of 'watchlist_movie_status_bloc.dart';

abstract class WatchlistMovieStatusEvent extends Equatable {
  const WatchlistMovieStatusEvent();

  @override
  List<Object> get props => [];
}

class LoadWatchlistStatus extends WatchlistMovieStatusEvent {
  final int id;

  LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
