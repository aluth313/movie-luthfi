import 'package:series/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class SeasonModel extends Equatable {
  SeasonModel({
    required this.seasonNumber,
  });

  final int seasonNumber;

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "season_number": seasonNumber,
      };

  Season toEntity() {
    return Season(
      seasonNumber: this.seasonNumber,
    );
  }

  @override
  List<Object?> get props => [
        seasonNumber,
      ];
}
