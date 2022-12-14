import 'package:movie/domain/entities/genre.dart';
import 'package:series/data/models/tv_table.dart';
import 'package:series/domain/entities/episode.dart';
import 'package:series/domain/entities/season.dart';
import 'package:series/domain/entities/tv.dart';
import 'package:series/domain/entities/tv_detail.dart';

final tSeries = Tv(
  backdropPath: '/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg',
  genreIds: [18, 9648],
  id: 31917,
  originalName: 'Pretty Little Liars',
  overview:
      'Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.',
  popularity: 47.432451,
  posterPath: '/vC324sdfcS313vh9QXwijLIHPJp.jpg',
  firstAirDate: '2010-06-08',
  name: 'Pretty Little Liars',
  voteAverage: 5.04,
  voteCount: 133,
  originCountry: ['US'],
  originalLanguage: 'en',
);

final testSeriesList = [tSeries];

final testSeriesDetail = TvDetail(
  name: 'All of Us Are Dead',
  genres: [
    Genre(id: 10759, name: 'Action & Adventure'),
    Genre(id: 18, name: 'Drama'),
    Genre(id: 10765, name: 'Sci-Fi & Fantasy'),
  ],
  id: 1,
  seasons: [
    Season(seasonNumber: 1),
    Season(seasonNumber: 2),
  ],
  overview:
      'A high school becomes ground zero for a zombie virus outbreak. Trapped students must fight their way out — or turn into one of the rabid infected.',
  posterPath: '/8gjbGKe5WNOaLrkoeOUPLvDhPhK.jpg',
  runtime: [53],
  voteAverage: 8.424,
);

final testEpisode = Episode(
  episodeNumber: 1,
  runtime: 66,
  stillPath: '/1JupR6vLoYYJb1ySERUCZ3k1qJW.jpg',
  overview:
      'Inside Lee Byeong-chan\'s science lab, a student incurs a seemingly harmless bite. Shortly after, a fast-spreading outbreak soaks the school in blood.',
);

final testWatchlistSeries = Tv.watchlist(
  id: 1,
  name: 'All of Us Are Dead',
  posterPath: '/8gjbGKe5WNOaLrkoeOUPLvDhPhK.jpg',
  overview:
      'A high school becomes ground zero for a zombie virus outbreak. Trapped students must fight their way out — or turn into one of the rabid infected.',
);

final testSeriesTable = TvTable(
  id: 1,
  name: 'All of Us Are Dead',
  posterPath: '/8gjbGKe5WNOaLrkoeOUPLvDhPhK.jpg',
  overview:
      'A high school becomes ground zero for a zombie virus outbreak. Trapped students must fight their way out — or turn into one of the rabid infected.',
);

final testSeriesMap = {
  'id': 1,
  'overview':
      'A high school becomes ground zero for a zombie virus outbreak. Trapped students must fight their way out — or turn into one of the rabid infected.',
  'posterPath': '/8gjbGKe5WNOaLrkoeOUPLvDhPhK.jpg',
  'name': 'All of Us Are Dead',
};
