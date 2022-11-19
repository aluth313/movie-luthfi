import 'package:ditonton/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class EpisodeModel extends Equatable {
  EpisodeModel({
    required this.episodeNumber,
    required this.runtime,
    required this.stillPath,
    required this.overview,
  });

  final int episodeNumber;
  final int? runtime;
  final String? stillPath;
  final String overview;

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
        episodeNumber: json["episode_number"],
        runtime: json["runtime"],
        stillPath: json["still_path"],
        overview: json["overview"],
      );

  Map<String, dynamic> toJson() => {
        "episode_number": episodeNumber,
        "runtime": runtime,
        "still_path": stillPath,
        "overview": overview,
      };

  Episode toEntity() {
    return Episode(
      episodeNumber: this.episodeNumber,
      runtime: this.runtime,
      stillPath: this.stillPath,
      overview: this.overview,
    );
  }

  @override
  List<Object?> get props => [
        episodeNumber,
        runtime,
        stillPath,
        overview,
      ];
}
