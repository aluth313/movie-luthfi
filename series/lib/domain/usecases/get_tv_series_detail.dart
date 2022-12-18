import 'package:dartz/dartz.dart';
import 'package:series/domain/entities/tv_detail.dart';
import 'package:core/common/failure.dart';
import 'package:series/domain/repositories/tv_repository.dart';

class GetTvSeriesDetail {
  final TvRepository repository;

  GetTvSeriesDetail(this.repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getTvSeriesDetail(id);
  }
}
