import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/movies_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movies_search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MoviesSearchBloc moviesSearchBloc;
  late MockSearchMovies mockSearchMovies;

  setUp(
    () {
      mockSearchMovies = MockSearchMovies();
      moviesSearchBloc = MoviesSearchBloc(mockSearchMovies);
    },
  );

  test(
    'initial state should be empty',
    () {
      expect(moviesSearchBloc.state, MoviesSearchEmpty());
    },
  );

  blocTest<MoviesSearchBloc, MoviesSearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchMovies.execute('adam'))
          .thenAnswer((_) async => Right(testMovieList));
      return moviesSearchBloc;
    },
    act: (bloc) => bloc.add(FetchMoviesSearch('adam')),
    expect: () => [
      MoviesSearchLoading(),
      MoviesSearchHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute('adam'));
    },
  );

  blocTest<MoviesSearchBloc, MoviesSearchState>(
    'Should emit [Loading, Error] when data is gotten unsuccessful',
    build: () {
      when(mockSearchMovies.execute('adam'))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return moviesSearchBloc;
    },
    act: (bloc) => bloc.add(FetchMoviesSearch('adam')),
    expect: () => [
      MoviesSearchLoading(),
      MoviesSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute('adam'));
    },
  );
}
