import 'package:core/common/constants.dart';
import 'package:core/common/utils.dart';
import 'package:ditonton/presentation/bloc/watchlist_movies_data_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_series_data_bloc.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_series_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        // Provider.of<WatchlistMovieNotifier>(context, listen: false)
        //     .fetchWatchlistMovies()
        context.read<WatchlistMoviesDataBloc>().add(FetchWatchlistMovies()));
    Future.microtask(() => context
            .read<WatchlistTvSeriesDataBloc>()
            .add(FetchWatchlistSeries())
        // Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
        //     .fetchWatchlistSeries()
        );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistMoviesDataBloc>().add(FetchWatchlistMovies());
    context.read<WatchlistTvSeriesDataBloc>().add(FetchWatchlistSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<WatchlistMoviesDataBloc, WatchlistMoviesDataState>(
                builder: (context, state) {
                  if (state is WatchlistMoviesDataLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is WatchlistMoviesDataHasData) {
                    return state.result.length > 0
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Movies',
                                style: kHeading6,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              ListView.builder(
                                padding: EdgeInsets.only(bottom: 15),
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final movie = state.result[index];
                                  return MovieCard(movie);
                                },
                                itemCount: state.result.length,
                              ),
                            ],
                          )
                        : SizedBox();
                  } else if (state is WatchlistMoviesDataError) {
                    return Center(
                      key: Key('error_message'),
                      child: Text(state.message),
                    );
                  } else {
                    return Center(
                      child: Text('Failed'),
                    );
                  }
                },
              ),
              Consumer<WatchlistTvSeriesNotifier>(
                builder: (context, data, child) {
                  if (data.watchlistState == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (data.watchlistState == RequestState.Loaded) {
                    return data.watchlistSeries.length > 0
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'TV Series',
                                style: kHeading6,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final series = data.watchlistSeries[index];
                                  return TvSeriesCard(series);
                                },
                                itemCount: data.watchlistSeries.length,
                              ),
                            ],
                          )
                        : SizedBox();
                  } else {
                    return Center(
                      key: Key('error_message'),
                      child: Text(data.message),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
