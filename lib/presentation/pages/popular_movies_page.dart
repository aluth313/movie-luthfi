import 'package:ditonton/presentation/bloc/popular_movies_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<PopularMoviesBloc>().add(FetchPopularMovies()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
          builder: (contextPopularMovies, statePopularMovies) {
            if (statePopularMovies is PopularMoviesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (statePopularMovies is PopularMoviesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = statePopularMovies.result[index];
                  return MovieCard(movie);
                },
                itemCount: statePopularMovies.result.length,
              );
            } else if (statePopularMovies is PopularMoviesError) {
              return Center(
                key: Key('error_message'),
                child: Text(statePopularMovies.message),
              );
            } else {
              return Center(child: Text('Failed'));
            }
          },
        ),
      ),
    );
  }
}
