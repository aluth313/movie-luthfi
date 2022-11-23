import 'package:ditonton/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

class TVModel extends Equatable {
  TVModel({
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
  final List<int> genreIds;
  final List<String> originCountry;
  final int id;
  final String originalName;
  final String originalLanguage;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String name;
  final double voteAverage;
  final int voteCount;
  final String? firstAirDate;

  factory TVModel.fromJson(Map<String, dynamic> json) => TVModel(
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        id: json["id"],
        originalName: json["original_name"],
        originalLanguage: json["original_language"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        name: json["name"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        firstAirDate: json["first_air_date"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "id": id,
        "original_name": originalName,
        "original_language": originalLanguage,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "name": name,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "first_air_date": firstAirDate,
      };

  Tv toEntity() {
    return Tv(
      backdropPath: this.backdropPath,
      genreIds: this.genreIds,
      originCountry: this.originCountry,
      id: this.id,
      originalName: this.originalName,
      originalLanguage: this.originalLanguage,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      name: this.name,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
      firstAirDate: this.firstAirDate,
    );
  }

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
