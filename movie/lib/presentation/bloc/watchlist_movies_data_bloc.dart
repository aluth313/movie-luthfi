import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';

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
