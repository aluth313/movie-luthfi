part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesState extends Equatable {
  const WatchlistMoviesState();

  @override
  List<Object> get props => [];
}

class WatchlistMoviesInitial extends WatchlistMoviesState {}

class WatchlistMoviesError extends WatchlistMoviesState {
  final String message;

  WatchlistMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMoviesAdded extends WatchlistMoviesState {
  final String message;

  WatchlistMoviesAdded(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMoviesRemoved extends WatchlistMoviesState {
  final String message;

  WatchlistMoviesRemoved(this.message);

  @override
  List<Object> get props => [message];
}

class IsWatchlistMovies extends WatchlistMoviesState {}

class IsNotWatchlistMovies extends WatchlistMoviesState {}
