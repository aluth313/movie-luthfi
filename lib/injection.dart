import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/http_ssl_pinning.dart';
import 'package:movie/data/datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:series/data/datasources/tv_local_data_source.dart';
import 'package:series/data/datasources/tv_remote_data_source.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:series/domain/repositories/tv_repository.dart';
import 'package:series/domain/usecases/get_airing_today_tv_series.dart';
import 'package:series/domain/usecases/get_episodes.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:series/domain/usecases/get_popular_tv.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:series/domain/usecases/get_top_rated_tv_series.dart';
import 'package:series/domain/usecases/get_tv_series_detail.dart';
import 'package:series/domain/usecases/get_tv_series_recommendations.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:series/domain/usecases/get_watchlist_tv_series.dart';
import 'package:series/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:series/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:series/domain/usecases/save_watchlist_tv_series.dart';
import 'package:movie/domain/usecases/search_movies.dart';
import 'package:series/domain/usecases/search_tv_series.dart';
import 'package:series/presentation/bloc/airing_today_tv_series_bloc.dart';
import 'package:series/presentation/bloc/episodes_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movies_recommendations_bloc.dart';
import 'package:movie/presentation/bloc/movies_search_bloc.dart';
import 'package:movie/presentation/bloc/now_playing_movies_bloc.dart';
import 'package:movie/presentation/bloc/popular_movies_bloc.dart';
import 'package:series/presentation/bloc/popular_tv_series_bloc.dart';
import 'package:series/presentation/bloc/selected_season_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movies_bloc.dart';
import 'package:series/presentation/bloc/top_rated_tv_series_bloc.dart';
import 'package:series/presentation/bloc/tv_series_detail_bloc.dart';
import 'package:series/presentation/bloc/tv_series_recommendations_bloc.dart';
import 'package:series/presentation/bloc/tv_series_search_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie_status_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movies_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movies_data_bloc.dart';
import 'package:series/presentation/bloc/watchlist_tv_series_bloc.dart';
import 'package:series/presentation/bloc/watchlist_tv_series_data_bloc.dart';
import 'package:series/presentation/bloc/watchlist_tv_series_status_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:series/data/repositories/tv_repository_impl.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(
    () => AiringTodayTvSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesRecommendationsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SelectedSeasonBloc(),
  );
  locator.registerFactory(
    () => EpisodesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvSeriesBloc(
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvSeriesStatusBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MoviesSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MoviesRecommendationsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieStatusBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMoviesDataBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvSeriesDataBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMoviesBloc(
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => SearchSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => GetEpisodes(locator()));
  locator.registerLazySingleton(() => GetWatchListTvSeriesStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedSeries(locator()));
  locator.registerLazySingleton(() => GetAiringTodaySeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
