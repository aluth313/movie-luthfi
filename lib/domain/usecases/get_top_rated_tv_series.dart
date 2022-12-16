import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetTopRatedSeries {
  final TvRepository repository;

  GetTopRatedSeries(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTopRatedSeries();
  }
}
