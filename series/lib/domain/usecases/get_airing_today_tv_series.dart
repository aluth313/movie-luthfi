import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:series/domain/entities/tv.dart';
import 'package:series/domain/repositories/tv_repository.dart';

class GetAiringTodaySeries {
  final TvRepository repository;

  GetAiringTodaySeries(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getAiringTodaySeries();
  }
}
