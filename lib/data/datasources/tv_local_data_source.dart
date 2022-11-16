import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_table.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlist(TvTable tv);
  Future<String> removeWatchlist(TvTable movie);
  Future<TvTable?> getSeriesById(int id);
  Future<List<TvTable>> getWatchlistSeries();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(TvTable series) async {
    try {
      await databaseHelper.insertWatchlist(MovieTable(
          id: series.id,
          title: series.title,
          posterPath: series.posterPath,
          overview: series.overview));
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvTable series) async {
    try {
      await databaseHelper.removeWatchlist(MovieTable(
          id: series.id,
          title: series.title,
          posterPath: series.posterPath,
          overview: series.overview));
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvTable?> getSeriesById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchlistSeries() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => TvTable.fromMap(data)).toList();
  }

  // @override
  // Future<TvTable?> getMovieById(int id) async {
  //   final result = await databaseHelper.getMovieById(id);
  //   if (result != null) {
  //     return TvTable.fromMap(result);
  //   } else {
  //     return null;
  //   }
  // }

  // @override
  // Future<List<TvTable>> getWatchlistMovies() async {
  //   final result = await databaseHelper.getWatchlistMovies();
  //   return result.map((data) => TvTable.fromMap(data)).toList();
  // }
}
