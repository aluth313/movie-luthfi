import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getPopularTv();
  // Future<Either<Failure, List<Movie>>> getTopRatedMovies();
  // Future<Either<Failure, MovieDetail>> getMovieDetail(int id);
  // Future<Either<Failure, List<Movie>>> getMovieRecommendations(int id);
  // Future<Either<Failure, List<Movie>>> searchMovies(String query);
  // Future<Either<Failure, String>> saveWatchlist(MovieDetail movie);
  // Future<Either<Failure, String>> removeWatchlist(MovieDetail movie);
  // Future<bool> isAddedToWatchlist(int id);
  // Future<Either<Failure, List<Movie>>> getWatchlistMovies();
}
