import 'package:dartz/dartz.dart';
import 'package:series/domain/entities/tv.dart';
import 'package:core/common/failure.dart';
import 'package:series/domain/repositories/tv_repository.dart';

class GetWatchlistSeries {
  final TvRepository _repository;

  GetWatchlistSeries(this._repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getWatchlistSeries();
  }
}
