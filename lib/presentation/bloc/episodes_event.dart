part of 'episodes_bloc.dart';

abstract class EpisodesEvent {
  const EpisodesEvent();
}

class FetchEpisodes extends EpisodesEvent {
  final int id;
  final int seasonNumber;

  FetchEpisodes(this.id, this.seasonNumber);
}
