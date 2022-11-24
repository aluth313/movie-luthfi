import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/episodes.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

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

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

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

final testEpisode = Episodes(episodes: [
  Episode(
    episodeNumber: 1,
    runtime: 66,
    stillPath: '/1JupR6vLoYYJb1ySERUCZ3k1qJW.jpg',
    overview:
        'Inside Lee Byeong-chan\'s science lab, a student incurs a seemingly harmless bite. Shortly after, a fast-spreading outbreak soaks the school in blood.',
  )
]);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};
