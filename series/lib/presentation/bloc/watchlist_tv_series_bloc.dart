import 'package:bloc/bloc.dart';
import 'package:series/domain/entities/tv_detail.dart';
import 'package:series/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:series/domain/usecases/save_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc
    extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final SaveWatchlistTvSeries saveWatchlist;
  final RemoveWatchlistSeries removeWatchlist;

  WatchlistTvSeriesBloc({
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(WatchlistTvSeriesInitial()) {
    on<AddWatchlist>((event, emit) async {
      final series = event.series;
      emit(WatchlistTvSeriesInitial());
      final result = await saveWatchlist.execute(series);

      await result.fold(
        (failure) async {
          emit(WatchlistTvSeriesError(failure.message));
        },
        (successMessage) async {
          emit(WatchlistTvSeriesAdded(successMessage));
        },
      );
    });

    on<RemoveFromWatchlist>((event, emit) async {
      final series = event.series;
      emit(WatchlistTvSeriesInitial());
      final result = await removeWatchlist.execute(series);

      await result.fold(
        (failure) async {
          emit(WatchlistTvSeriesError(failure.message));
        },
        (successMessage) async {
          emit(WatchlistTvSeriesRemoved(successMessage));
        },
      );
    });
  }
}
