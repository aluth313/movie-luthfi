part of 'episodes_bloc.dart';

abstract class EpisodesState extends Equatable {
  const EpisodesState();

  @override
  List<Object> get props => [];
}

class EpisodeEmpty extends EpisodesState {}

class EpisodeLoading extends EpisodesState {}

class EpisodeError extends EpisodesState {
  final String message;

  EpisodeError(this.message);

  @override
  List<Object> get props => [message];
}

class EpisodeHasData extends EpisodesState {
  final List<Episode> episodes;

  EpisodeHasData(this.episodes);

  @override
  List<Object> get props => [episodes];
}
