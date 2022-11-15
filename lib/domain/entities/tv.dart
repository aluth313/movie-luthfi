import 'package:equatable/equatable.dart';

class Tv extends Equatable {
  Tv({
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

  Tv.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  String? backdropPath;
  List<int>? genreIds;
  List<String>? originCountry;
  int? id;
  String? originalName;
  String? originalLanguage;
  String? overview;
  double? popularity;
  String? posterPath;
  String? name;
  double? voteAverage;
  int? voteCount;
  String? firstAirDate;

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
