import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class RemoveWatchlistSeries {
  final TvRepository repository;

  RemoveWatchlistSeries(this.repository);

  Future<Either<Failure, String>> execute(TvDetail series) {
    return repository.removeWatchlist(series);
  }
}
