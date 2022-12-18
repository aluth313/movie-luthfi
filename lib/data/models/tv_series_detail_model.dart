import 'package:movie/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetailResponse extends Equatable {
  TvSeriesDetailResponse({
    required this.genres,
    required this.seasons,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.runtime,
    required this.name,
    required this.voteAverage,
  });

  final List<GenreModel> genres;
  final List<SeasonModel> seasons;
  final int id;
  final String overview;
  final String posterPath;
  final List<int>? runtime;
  final String name;
  final double voteAverage;

  factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailResponse(
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        seasons: List<SeasonModel>.from(
            json["seasons"].map((x) => SeasonModel.fromJson(x))),
        id: json["id"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        runtime: List<int>.from(json["episode_run_time"].map((x) => x)),
        name: json["name"],
        voteAverage: json["vote_average"].toDouble(),
      );

  TvDetail toEntity() {
    return TvDetail(
      genres: this.genres.map((genre) => genre.toEntity()).toList(),
      seasons: this.seasons.map((season) => season.toEntity()).toList(),
      id: this.id,
      overview: this.overview,
      posterPath: this.posterPath,
      runtime: this.runtime,
      name: this.name,
      voteAverage: this.voteAverage,
    );
  }

  @override
  List<Object?> get props => [
        genres,
        seasons,
        id,
        overview,
        posterPath,
        runtime,
        voteAverage,
        name,
      ];
}
