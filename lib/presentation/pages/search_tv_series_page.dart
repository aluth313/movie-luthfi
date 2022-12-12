import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/tv_series_search_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchSeriesPage extends StatelessWidget {
  const SearchSeriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onSubmitted: (query) {
              context.read<TvSeriesSearchBloc>().add(FetchSeriesSearch(query));
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
          BlocBuilder<TvSeriesSearchBloc, TvSeriesSearchState>(
            builder: (context, state) {
              if (state is TvSeriesSearchLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvSeriesSearchHasData) {
                final result = state.result;
                return result.length > 0
                    ? Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (context, index) {
                            final series = result[index];
                            return TvSeriesCard(series);
                          },
                          itemCount: result.length,
                        ),
                      )
                    : Expanded(
                        child: Center(
                          child: Text('Series not found.'),
                        ),
                      );
              } else if (state is TvSeriesSearchError) {
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
