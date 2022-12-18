import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:series/domain/entities/episode.dart';
import 'package:series/domain/repositories/tv_repository.dart';

class GetEpisodes {
  final TvRepository repository;

  GetEpisodes(this.repository);

  Future<Either<Failure, List<Episode>>> execute(int tvId, int sessionNumber) {
    return repository.getEpisodesBySessionNumber(tvId, sessionNumber);
  }
}
