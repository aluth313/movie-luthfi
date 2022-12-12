part of 'movies_search_bloc.dart';

abstract class MoviesSearchState extends Equatable {
  const MoviesSearchState();

  @override
  List<Object> get props => [];
}

class MoviesSearchEmpty extends MoviesSearchState {}

class MoviesSearchLoading extends MoviesSearchState {}

class MoviesSearchError extends MoviesSearchState {
  final String message;

  MoviesSearchError(this.message);

  @override
  List<Object> get props => [message];
}

class MoviesSearchHasData extends MoviesSearchState {
  final List<Movie> result;

  MoviesSearchHasData(this.result);

  @override
  List<Object> get props => [result];
}
