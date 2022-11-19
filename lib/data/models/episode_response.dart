import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/domain/entities/episodes.dart';
import 'package:equatable/equatable.dart';

class EpisodeResponse extends Equatable {
  EpisodeResponse({
        required this.episodes,
    });

    final List<EpisodeModel> episodes;

    factory EpisodeResponse.fromJson(Map<String, dynamic> json) => EpisodeResponse(
        episodes: List<EpisodeModel>.from(json["episodes"].map((x) => EpisodeModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
    };

    Episodes toEntity() {
    return Episodes(
      episodes: this.episodes.map((episode) => episode.toEntity()).toList(),
    );
  }

  @override
  List<Object> get props => [episodes];
}
