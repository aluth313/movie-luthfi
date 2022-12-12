import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/movies_search_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchMoviesPage extends StatelessWidget {
  const SearchMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onSubmitted: (query) {
              context.read<MoviesSearchBloc>().add(FetchMoviesSearch(query));
            },
            decoration: InputDecoration(
              hintText: 'Search title',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.search,
          ),
          SizedBox(height: 16),
          Text(
            'Search Result',
            style: kHeading6,
          ),
          BlocBuilder<MoviesSearchBloc, MoviesSearchState>(
            builder: (context, state) {
              if (state is MoviesSearchLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is MoviesSearchHasData) {
                final result = state.result;
                return result.length > 0
                    ? Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (context, index) {
                            final movie = result[index];
                            return MovieCard(movie);
                          },
                          itemCount: result.length,
                        ),
                      )
                    : Expanded(
                        child: Center(
                          child: Text('Movies not found.'),
                        ),
                      );
              } else if (state is MoviesSearchError) {
                return Expanded(
                  child: Center(
                    child: Text(state.message),
                  ),
                );
              } else {
                return Expanded(
                  child: Container(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
