import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/episodes_bloc.dart';
import 'package:ditonton/presentation/bloc/selected_season_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_recommendations_bloc.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/episode_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-series';

  final int id;
  TvSeriesDetailPage({required this.id});

  @override
  _TvSeriesDetailPageState createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvSeriesDetailBloc>().add(FetchTvSeriesDetail(widget.id));
      context.read<SelectedSeasonBloc>().add(SetSelectedSeasonEmpty());
      context
          .read<TvSeriesRecommendationsBloc>()
          .add(FetchRecommendations(widget.id));
      Provider.of<TvSeriesDetailNotifier>(context, listen: false)
          .loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvSeriesDetailBloc, TvSeriesDetailState>(
        builder: (contextDetail, stateDetail) {
          if (stateDetail is TvSeriesDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (stateDetail is TvSeriesDetailHasData) {
            final series = stateDetail.result;
            if (series.seasons != null && series.seasons!.length > 0) {
              context.read<SelectedSeasonBloc>().add(
                    SelectedSeason(series.seasons![0].seasonNumber),
                  );
              context.read<EpisodesBloc>().add(
                    FetchEpisodes(
                      series.id,
                      series.seasons![0].seasonNumber,
                    ),
                  );
            }
            return SafeArea(
              child: DetailContent(
                series,
                false,
              ),
            );
          } else if (stateDetail is TvSeriesDetailError) {
            return Text(stateDetail.message);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvDetail series;
  // final List<Tv> recommendations;
  final bool isAddedWatchlist;

  DetailContent(this.series, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${series.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        key: Key('scroll_view_detail_key'),
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              series.name!,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              key: Key('watchlist_button_key'),
                              onPressed: () async {
                                // if (!isAddedWatchlist) {
                                //   await Provider.of<TvSeriesDetailNotifier>(
                                //           context,
                                //           listen: false)
                                //       .addWatchlist(series);
                                // } else {
                                //   await Provider.of<TvSeriesDetailNotifier>(
                                //           context,
                                //           listen: false)
                                //       .removeFromWatchlist(series);
                                // }

                                // final message =
                                //     Provider.of<TvSeriesDetailNotifier>(context,
                                //             listen: false)
                                //         .watchlistMessage;

                                // if (message ==
                                //         TvSeriesDetailNotifier
                                //             .watchlistAddSuccessMessage ||
                                //     message ==
                                //         TvSeriesDetailNotifier
                                //             .watchlistRemoveSuccessMessage) {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //       SnackBar(content: Text(message)));
                                // } else {
                                //   showDialog(
                                //       context: context,
                                //       builder: (context) {
                                //         return AlertDialog(
                                //           content: Text(message),
                                //         );
                                //       });
                                // }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(series.genres!),
                            ),
                            Text(
                              series.runtime!.length > 0
                                  ? _showDuration(series.runtime![0])
                                  : '-',
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: series.voteAverage! / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${series.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              series.overview!.isNotEmpty
                                  ? series.overview!
                                  : '-',
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Episodes',
                              style: kHeading6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Seasons',
                                  style: kHeading6,
                                ),
                                series.seasons!.length > 0
                                    ? BlocBuilder<SelectedSeasonBloc,
                                        SelectedSeasonState>(
                                        builder: (context, state) {
                                          if (state is SelectedSeasonHasData) {
                                            return DropdownButton(
                                              value: state.selectedSeason,
                                              icon: const Icon(
                                                  Icons.keyboard_arrow_down),
                                              items:
                                                  series.seasons?.map((item) {
                                                return DropdownMenuItem(
                                                  value: item.seasonNumber,
                                                  child: Text(
                                                      'Season ${item.seasonNumber.toString()}'),
                                                );
                                              }).toList(),
                                              onChanged: (int? newValue) {
                                                context
                                                    .read<SelectedSeasonBloc>()
                                                    .add(SelectedSeason(
                                                        newValue!));
                                                context
                                                    .read<EpisodesBloc>()
                                                    .add(FetchEpisodes(
                                                        series.id, newValue));
                                              },
                                            );
                                          } else if (state
                                              is SelectedSeasonEmpty) {
                                            return Text('No Season');
                                          } else {
                                            return Container();
                                          }
                                        },
                                      )
                                    : Text('No Season'),
                              ],
                            ),
                            BlocBuilder<EpisodesBloc, EpisodesState>(
                              builder: (context, state) {
                                return Container(
                                  height: 230,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      if (state is EpisodeLoading) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (state is EpisodeError) {
                                        return Text(state.message);
                                      } else if (state is EpisodeHasData) {
                                        return EpisodeCard(
                                          episode: state.episodes[index],
                                        );
                                      }
                                      return Container();
                                    },
                                    itemCount: state is EpisodeHasData
                                        ? state.episodes.length
                                        : 0,
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvSeriesRecommendationsBloc,
                                TvSeriesRecommendationsState>(
                              builder: (context, state) {
                                if (state is TvSeriesRecommendationsLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is TvSeriesRecommendationsError) {
                                  return Text(state.message);
                                } else if (state
                                    is TvSeriesRecommendationsHasData) {
                                  return Container(
                                    height: 150,
                                    child: state.recommendations.length > 0
                                        ? ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              final series =
                                                  state.recommendations[index];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator
                                                        .pushReplacementNamed(
                                                      context,
                                                      TvSeriesDetailPage
                                                          .ROUTE_NAME,
                                                      arguments: series.id,
                                                    );
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(8),
                                                    ),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          'https://image.tmdb.org/t/p/w500${series.posterPath}',
                                                      placeholder:
                                                          (context, url) =>
                                                              Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            itemCount:
                                                state.recommendations.length,
                                          )
                                        : Text('There is no recommendations'),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
