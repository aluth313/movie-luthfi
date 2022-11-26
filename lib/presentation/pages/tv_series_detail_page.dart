import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/episode_card_list.dart';
import 'package:flutter/material.dart';
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
      Provider.of<TvSeriesDetailNotifier>(context, listen: false)
          .fetchTvSeriesDetail(widget.id);
      Provider.of<TvSeriesDetailNotifier>(context, listen: false)
          .loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvSeriesDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.tvSeriesState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvSeriesState == RequestState.Loaded) {
            final series = provider.series;
            return SafeArea(
              child: DetailContent(
                series,
                provider.tvSeriesRecommendations,
                provider.isAddedToWatchlist,
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvDetail series;
  final List<Tv> recommendations;
  final bool isAddedWatchlist;

  DetailContent(this.series, this.recommendations, this.isAddedWatchlist);

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
                                if (!isAddedWatchlist) {
                                  await Provider.of<TvSeriesDetailNotifier>(
                                          context,
                                          listen: false)
                                      .addWatchlist(series);
                                } else {
                                  await Provider.of<TvSeriesDetailNotifier>(
                                          context,
                                          listen: false)
                                      .removeFromWatchlist(series);
                                }

                                final message =
                                    Provider.of<TvSeriesDetailNotifier>(context,
                                            listen: false)
                                        .watchlistMessage;

                                if (message ==
                                        TvSeriesDetailNotifier
                                            .watchlistAddSuccessMessage ||
                                    message ==
                                        TvSeriesDetailNotifier
                                            .watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
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
                                    ? Consumer<TvSeriesDetailNotifier>(
                                        builder: (context, data, child) {
                                          if (data.selectedSeasonIdState ==
                                              RequestState.Loaded) {
                                            return DropdownButton(
                                              value: data.selectedSessionId,
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
                                                data.fetchEpisodesBySessionNumber(
                                                    series.id, newValue!);
                                              },
                                            );
                                          }
                                          return Container();
                                        },
                                      )
                                    : Text('No Season')
                              ],
                            ),
                            Consumer<TvSeriesDetailNotifier>(
                              builder: (context, dataEpisode, child) {
                                return Container(
                                  height: 230,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      if (dataEpisode.episodeState ==
                                          RequestState.Loading) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (dataEpisode.episodeState ==
                                          RequestState.Error) {
                                        return Text(dataEpisode.message);
                                      } else if (dataEpisode.episodeState ==
                                          RequestState.Loaded) {
                                        return EpisodeCard(
                                          episode: dataEpisode
                                              .episodes[index],
                                        );
                                      }
                                      return Container();
                                    },
                                    itemCount:
                                        dataEpisode.episodes.length,
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            Consumer<TvSeriesDetailNotifier>(
                              builder: (context, data, child) {
                                if (data.recommendationState ==
                                    RequestState.Loading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (data.recommendationState ==
                                    RequestState.Error) {
                                  return Text(data.message);
                                } else if (data.recommendationState ==
                                    RequestState.Loaded) {
                                  return Container(
                                    height: 150,
                                    child: recommendations.length > 0
                                        ? ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              final series =
                                                  recommendations[index];
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
                                            itemCount: recommendations.length,
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
