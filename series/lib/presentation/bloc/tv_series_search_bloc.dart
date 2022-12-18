import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/domain/entities/tv.dart';
import 'package:series/domain/usecases/search_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_search_event.dart';
part 'tv_series_search_state.dart';

class TvSeriesSearchBloc
    extends Bloc<TvSeriesSearchEvent, TvSeriesSearchState> {
  final SearchSeries searchSeries;

  TvSeriesSearchBloc(this.searchSeries) : super(TvSeriesSearchEmpty()) {
    on<FetchSeriesSearch>((event, emit) async {
      final query = event.query;
      emit(TvSeriesSearchLoading());

      final result = await searchSeries.execute(query);
      result.fold(
        (failure) {
          emit(TvSeriesSearchError(failure.message));
        },
        (data) {
          emit(TvSeriesSearchHasData(data));
        },
      );
    });
  }
}
