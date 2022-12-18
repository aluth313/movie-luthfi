import 'package:bloc/bloc.dart';
import 'package:series/domain/entities/tv.dart';
import 'package:series/domain/usecases/get_airing_today_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'airing_today_tv_series_event.dart';
part 'airing_today_tv_series_state.dart';

class AiringTodayTvSeriesBloc
    extends Bloc<FetchAiringTodaySeries, AiringTodayTvSeriesState> {
  final GetAiringTodaySeries _getAiringTodaySeries;

  AiringTodayTvSeriesBloc(this._getAiringTodaySeries)
      : super(AiringTodayTvSeriesEmpty()) {
    on<FetchAiringTodaySeries>((event, emit) async {
      emit(AiringTodayTvSeriesLoading());
      final result = await _getAiringTodaySeries.execute();

      result.fold(
        (failure) {
          emit(AiringTodayTvSeriesError(failure.message));
        },
        (seriesData) {
          emit(AiringTodayTvSeriesHasData(seriesData));
        },
      );
    });
  }
}
