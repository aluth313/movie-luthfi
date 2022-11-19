import 'package:equatable/equatable.dart';

class Season extends Equatable {
  Season({
    required this.seasonNumber,
  });

  final int seasonNumber;

  @override
  List<Object> get props => [
        seasonNumber,
      ];
}
