import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/episodes.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetEpisodes {
  final TvRepository repository;

  GetEpisodes(this.repository);

  Future<Either<Failure, List<Episode>>> execute(int tvId, int sessionNumber) {
    return repository.getEpisodesBySessionNumber(tvId, sessionNumber);
  }
}
