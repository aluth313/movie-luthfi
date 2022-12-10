import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/usecases/get_episodes.dart';
import 'package:equatable/equatable.dart';

part 'episodes_event.dart';
part 'episodes_state.dart';

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState> {
  final GetEpisodes _getEpisodes;

  EpisodesBloc(this._getEpisodes) : super(EpisodeEmpty()) {
    on<FetchEpisodes>((event, emit) async {
      final id = event.id;
      final seasonNumber = event.seasonNumber;

      emit(EpisodeLoading());
      final episodeResult = await _getEpisodes.execute(
        id,
        seasonNumber,
      );
      episodeResult.fold((failure) {
        emit(EpisodeError(failure.message));
      }, (episodes) {
        emit(EpisodeHasData(episodes));
      });
    });
  }
}
