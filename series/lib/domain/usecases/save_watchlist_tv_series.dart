import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:series/domain/entities/tv_detail.dart';
import 'package:series/domain/repositories/tv_repository.dart';

class SaveWatchlistTvSeries {
  final TvRepository repository;

  SaveWatchlistTvSeries(this.repository);

  Future<Either<Failure, String>> execute(TvDetail series) {
    return repository.saveWatchlist(series);
  }
}
