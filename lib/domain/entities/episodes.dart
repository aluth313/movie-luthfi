import 'package:ditonton/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class Episodes extends Equatable {
  Episodes({
    required this.episodes,
  });

  final List<Episode> episodes;

  @override
  List<Object> get props => [
        episodes,
      ];
}
