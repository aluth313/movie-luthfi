import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  TvDetail({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
    required this.voteAverage,
    required this.genres,
    required this.seasons,
    required this.runtime,
  });

  final List<Genre>? genres;
  final List<Season>? seasons;
  final int id;
  final String? overview;
  final String? posterPath;
  final List<int>? runtime;
  final String? name;
  final double? voteAverage;

  @override
  List<Object?> get props => [
        id,
        overview,
        posterPath,
        name,
        voteAverage,
        genres,
        seasons,
        runtime,
      ];
}
