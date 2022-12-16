import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movies_data_event.dart';
part 'watchlist_movies_data_state.dart';

class WatchlistMoviesDataBloc
    extends Bloc<WatchlistMoviesDataEvent, WatchlistMoviesDataState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMoviesDataBloc(this.getWatchlistMovies)
      : super(WatchlistMoviesDataEmpty()) {
    on<FetchWatchlistMovies>((event, emit) async {
      emit(WatchlistMoviesDataLoading());

      final result = await getWatchlistMovies.execute();
      result.fold(
        (failure) {
          emit(WatchlistMoviesDataError(failure.message));
        },
        (moviesData) {
          emit(WatchlistMoviesDataHasData(moviesData));
        },
      );
    });
  }
}
