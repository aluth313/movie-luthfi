import 'package:dartz/dartz.dart';
import 'package:series/domain/entities/tv.dart';
import 'package:core/common/failure.dart';
import 'package:series/domain/repositories/tv_repository.dart';

class GetTvSeriesRecommendations {
  final TvRepository repository;

  GetTvSeriesRecommendations(this.repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return repository.getTvSeriesRecommendations(id);
  }
}
