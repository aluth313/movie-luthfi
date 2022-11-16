import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  TvDetail({
    required this.backdropPath,
    required this.genreIds,
    required this.originCountry,
    required this.id,
    required this.originalName,
    required this.originalLanguage,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
    required this.firstAirDate,
  });

  final String? backdropPath;
  final List<int>? genreIds;
  final List<String>? originCountry;
  final int id;
  final String? originalName;
  final String? originalLanguage;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? name;
  final double? voteAverage;
  final int? voteCount;
  final String? firstAirDate;

  @override
  List<Object?> get props => [
        backdropPath,
        genreIds,
        originCountry,
        id,
        originalName,
        originalLanguage,
        overview,
        popularity,
        posterPath,
        name,
        voteAverage,
        voteCount,
        firstAirDate,
      ];
}
