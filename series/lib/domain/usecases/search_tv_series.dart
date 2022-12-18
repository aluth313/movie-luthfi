import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:series/domain/entities/tv.dart';
import 'package:series/domain/repositories/tv_repository.dart';

class SearchSeries {
  final TvRepository repository;

  SearchSeries(this.repository);

  Future<Either<Failure, List<Tv>>> execute(String query) {
    return repository.searchSeries(query);
  }
}
