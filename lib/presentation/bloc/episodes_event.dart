part of 'episodes_bloc.dart';

abstract class EpisodesEvent extends Equatable {
  const EpisodesEvent();

  @override
  List<Object> get props => [];
}

class FetchEpisodes extends EpisodesEvent {
  final int id;
  final int seasonNumber;

  FetchEpisodes(this.id, this.seasonNumber);

  @override
  List<Object> get props => [id, seasonNumber];
}
