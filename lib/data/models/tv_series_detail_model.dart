import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetailResponse extends Equatable {
  TvSeriesDetailResponse({
    // required this.adult,
    // required this.backdropPath,
    // required this.budget,
    required this.genres,
    // required this.homepage,
    required this.id,
    // required this.imdbId,
    // required this.originalLanguage,
    // required this.originalTitle,
    required this.overview,
    // required this.popularity,
    required this.posterPath,
    // required this.releaseDate,
    // required this.revenue,
    required this.runtime,
    // required this.status,
    // required this.tagline,
    required this.name,
    // required this.video,
    required this.voteAverage,
    // required this.voteCount,
  });

  // final bool adult;
  // final String? backdropPath;
  // final int budget;
  final List<GenreModel> genres;
  // final String homepage;
  final int id;
  // final String? imdbId;
  // final String originalLanguage;
  // final String originalTitle;
  final String overview;
  // final double popularity;
  final String posterPath;
  // final String releaseDate;
  // final int revenue;
  final List<int>? runtime;
  // final String status;
  // final String tagline;
  final String name;
  // final bool video;
  final double voteAverage;
  // final int voteCount;

  factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailResponse(
        // adult: json["adult"],
        // backdropPath: json["backdrop_path"],
        // budget: json["budget"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        // homepage: json["homepage"],
        id: json["id"],
        // imdbId: json["imdb_id"],
        // originalLanguage: json["original_language"],
        // originalTitle: json["original_title"],
        overview: json["overview"],
        // popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        // releaseDate: json["release_date"],
        // revenue: json["revenue"],
        runtime: List<int>.from(json["episode_run_time"].map((x) => x)),
        // status: json["status"],
        // tagline: json["tagline"],
        name: json["name"],
        // video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        // voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        // "adult": adult,
        // "backdrop_path": backdropPath,
        // "budget": budget,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        // "homepage": homepage,
        "id": id,
        // "imdb_id": imdbId,
        // "original_language": originalLanguage,
        // "original_title": originalTitle,
        "overview": overview,
        // "popularity": popularity,
        "poster_path": posterPath,
        // "release_date": releaseDate,
        // "revenue": revenue,
        "episode_run_time": runtime,
        // "status": status,
        // "tagline": tagline,
        "name": name,
        // "video": video,
        "vote_average": voteAverage,
        // "vote_count": voteCount,
      };

  TvDetail toEntity() {
    return TvDetail(
      genres: this.genres.map((genre) => genre.toEntity()).toList(),
      id: this.id,
      overview: this.overview,
      posterPath: this.posterPath,
      runtime: this.runtime,
      name: this.name,
      voteAverage: this.voteAverage,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        genres,
        id,
        overview,
        posterPath,
        runtime,
        voteAverage,
        name,
      ];
}