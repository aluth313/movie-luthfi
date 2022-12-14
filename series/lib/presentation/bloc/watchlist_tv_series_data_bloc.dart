import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/domain/entities/tv.dart';
import 'package:series/domain/usecases/get_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_series_data_event.dart';
part 'watchlist_tv_series_data_state.dart';

class WatchlistTvSeriesDataBloc
    extends Bloc<WatchlistTvSeriesDataEvent, WatchlistTvSeriesDataState> {
  final GetWatchlistSeries getWatchlistSeries;

  WatchlistTvSeriesDataBloc(this.getWatchlistSeries)
      : super(WatchlistTvSeriesDataEmpty()) {
    on<FetchWatchlistSeries>((event, emit) async {
      emit(WatchlistTvSeriesDataLoading());

      final result = await getWatchlistSeries.execute();
      result.fold(
        (failure) {
          emit(WatchlistTvSeriesDataError(failure.message));
        },
        (moviesData) {
          emit(WatchlistTvSeriesDataHasData(moviesData));
        },
      );
    });
  }
}
