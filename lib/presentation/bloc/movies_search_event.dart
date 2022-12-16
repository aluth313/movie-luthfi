part of 'movies_search_bloc.dart';

abstract class MoviesSearchEvent {
  const MoviesSearchEvent();
}

class FetchMoviesSearch extends MoviesSearchEvent {
  final String query;

  FetchMoviesSearch(this.query);
}
