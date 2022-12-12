part of 'tv_series_search_bloc.dart';

abstract class TvSeriesSearchEvent extends Equatable {
  const TvSeriesSearchEvent();

  @override
  List<Object> get props => [];
}

class FetchSeriesSearch extends TvSeriesSearchEvent {
  final String query;

  FetchSeriesSearch(this.query);

  @override
  List<Object> get props => [query];
}
