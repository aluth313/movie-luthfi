import 'package:bloc/bloc.dart';
import 'package:series/domain/entities/tv.dart';
import 'package:series/domain/usecases/get_top_rated_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_tv_series_event.dart';
part 'top_rated_tv_series_state.dart';

class TopRatedTvSeriesBloc
    extends Bloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState> {
  final GetTopRatedSeries _getTopRatedSeries;

  TopRatedTvSeriesBloc(this._getTopRatedSeries)
      : super(TopRatedTvSeriesEmpty()) {
    on<FetchTopRatedSeries>((event, emit) async {
      emit(TopRatedTvSeriesLoading());
      final result = await _getTopRatedSeries.execute();

      result.fold(
        (failure) {
          emit(TopRatedTvSeriesError(failure.message));
        },
        (seriesData) {
          emit(TopRatedTvSeriesHasData(seriesData));
        },
      );
    });
  }
}
