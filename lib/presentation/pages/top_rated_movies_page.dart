import 'package:ditonton/presentation/bloc/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TopRatedMoviesBloc>().add(FetchTopRatedMovies()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
          builder: (contextTopRatedMovies, stateTopRatedMovies) {
            if (stateTopRatedMovies is TopRatedMoviesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (stateTopRatedMovies is TopRatedMoviesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = stateTopRatedMovies.result[index];
                  return MovieCard(movie);
                },
                itemCount: stateTopRatedMovies.result.length,
              );
            } else if (stateTopRatedMovies is TopRatedMoviesError) {
              return Center(
                key: Key('error_message'),
                child: Text(stateTopRatedMovies.message),
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
