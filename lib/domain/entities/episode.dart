import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  Episode({
    required this.episodeNumber,
    required this.runtime,
    required this.stillPath,
    required this.overview,
  });

  final int episodeNumber;
  final int? runtime;
  final String? stillPath;
  final String overview;

  @override
  List<Object?> get props => [
        episodeNumber,
        runtime,
        stillPath,
        overview,
      ];
}
