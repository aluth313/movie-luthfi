part of 'movies_search_bloc.dart';

abstract class MoviesSearchEvent extends Equatable {
  const MoviesSearchEvent();

  @override
  List<Object> get props => [];
}

class FetchMoviesSearch extends MoviesSearchEvent {
  final String query;

  FetchMoviesSearch(this.query);

  @override
  List<Object> get props => [query];
}
