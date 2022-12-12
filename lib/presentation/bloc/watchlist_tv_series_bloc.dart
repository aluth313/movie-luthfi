import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc
    extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final SaveWatchlistTvSeries saveWatchlist;
  final GetWatchListTvSeriesStatus getWatchListStatus;
  final RemoveWatchlistSeries removeWatchlist;

  WatchlistTvSeriesBloc({
    required this.saveWatchlist,
    required this.getWatchListStatus,
    required this.removeWatchlist,
  }) : super(WatchlistTvSeriesInitial()) {
    on<AddWatchlist>((event, emit) async {
      final series = event.series;
      final result = await saveWatchlist.execute(series);

      await result.fold(
        (failure) async {
          emit(WatchlistTvSeriesError(failure.message));
        },
        (successMessage) async {
          emit(WatchlistTvSeriesAdded(successMessage));
        },
      );

      add(LoadWatchlistStatus(series.id));
    });

    on<LoadWatchlistStatus>((event, emit) async {
      final id = event.id;
      final result = await getWatchListStatus.execute(id);
      result ? emit(IsWatchlistTvSeries()) : emit(IsNotWatchlistTvSeries());
    });

    on<RemoveFromWatchlist>((event, emit) async {
      final series = event.series;
      final result = await removeWatchlist.execute(series);

      await result.fold(
        (failure) async {
          emit(WatchlistTvSeriesError(failure.message));
        },
        (successMessage) async {
          emit(WatchlistTvSeriesRemoved(successMessage));
        },
      );

      add(LoadWatchlistStatus(series.id));
    });
  }
}
