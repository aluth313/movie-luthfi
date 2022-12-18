import 'package:bloc/bloc.dart';
import 'package:series/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_series_status_event.dart';
part 'watchlist_tv_series_status_state.dart';

class WatchlistTvSeriesStatusBloc
    extends Bloc<WatchlistTvSeriesStatusEvent, WatchlistTvSeriesStatusState> {
  final GetWatchListTvSeriesStatus getWatchListStatus;

  WatchlistTvSeriesStatusBloc(this.getWatchListStatus)
      : super(IsNotWatchlistTvSeries()) {
    on<LoadWatchlistStatus>((event, emit) async {
      final id = event.id;
      final result = await getWatchListStatus.execute(id);
      result ? emit(IsWatchlistTvSeries()) : emit(IsNotWatchlistTvSeries());
    });
  }
}
