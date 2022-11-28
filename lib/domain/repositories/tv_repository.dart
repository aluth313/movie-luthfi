import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getPopularTv();
  Future<Either<Failure, List<Tv>>> getTopRatedSeries();
  Future<Either<Failure, TvDetail>> getTvSeriesDetail(int id);
  Future<Either<Failure, List<Episode>>> getEpisodesBySessionNumber(
    int tvId,
    int sesionNumber,
  );
  Future<Either<Failure, List<Tv>>> getTvSeriesRecommendations(int id);
  Future<Either<Failure, List<Tv>>> searchSeries(String query);
  Future<Either<Failure, String>> saveWatchlist(TvDetail series);
  Future<Either<Failure, String>> removeWatchlist(TvDetail series);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Tv>>> getWatchlistSeries();
  Future<Either<Failure, List<Tv>>> getAiringTodaySeries();
}
