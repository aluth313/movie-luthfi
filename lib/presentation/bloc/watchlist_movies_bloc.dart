import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movies_event.dart';
part 'watchlist_movies_state.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final SaveWatchlist saveWatchlist;
  final GetWatchListStatus getWatchListStatus;
  final RemoveWatchlist removeWatchlist;

  WatchlistMoviesBloc({
    required this.saveWatchlist,
    required this.getWatchListStatus,
    required this.removeWatchlist,
  }) : super(WatchlistMoviesInitial()) {
    on<AddWatchlist>((event, emit) async {
      final movie = event.movie;
      final result = await saveWatchlist.execute(movie);

      await result.fold(
        (failure) async {
          emit(WatchlistMoviesError(failure.message));
        },
        (successMessage) async {
          emit(WatchlistMoviesAdded(successMessage));
        },
      );

      add(LoadWatchlistStatus(movie.id));
    });

    on<LoadWatchlistStatus>((event, emit) async {
      final id = event.id;
      final result = await getWatchListStatus.execute(id);
      result ? emit(IsWatchlistMovies()) : emit(IsNotWatchlistMovies());
    });

    on<RemoveFromWatchlist>((event, emit) async {
      final movie = event.movie;
      final result = await removeWatchlist.execute(movie);

      await result.fold(
        (failure) async {
          emit(WatchlistMoviesError(failure.message));
        },
        (successMessage) async {
          emit(WatchlistMoviesRemoved(successMessage));
        },
      );

      add(LoadWatchlistStatus(movie.id));
    });
  }
}
