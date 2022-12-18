import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecases/search_movies.dart';

part 'movies_search_event.dart';
part 'movies_search_state.dart';

class MoviesSearchBloc extends Bloc<MoviesSearchEvent, MoviesSearchState> {
  final SearchMovies searchMovies;

  MoviesSearchBloc(this.searchMovies) : super(MoviesSearchEmpty()) {
    on<FetchMoviesSearch>((event, emit) async {
      final query = event.query;
      emit(MoviesSearchLoading());

      final result = await searchMovies.execute(query);
      result.fold(
        (failure) {
          emit(MoviesSearchError(failure.message));
        },
        (data) {
          emit(MoviesSearchHasData(data));
        },
      );
    });
  }
}
