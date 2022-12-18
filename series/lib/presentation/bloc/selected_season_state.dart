part of 'selected_season_bloc.dart';

abstract class SelectedSeasonState extends Equatable {
  const SelectedSeasonState();

  @override
  List<Object> get props => [];
}

class SelectedSeasonEmpty extends SelectedSeasonState {}

class SelectedSeasonHasData extends SelectedSeasonState {
  final int selectedSeason;

  SelectedSeasonHasData(this.selectedSeason);

  @override
  List<Object> get props => [selectedSeason];
}
