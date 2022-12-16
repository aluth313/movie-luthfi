part of 'selected_season_bloc.dart';

abstract class SelectedSeasonEvent {
  const SelectedSeasonEvent();
}

class SelectedSeason extends SelectedSeasonEvent {
  final int selectedSeason;

  SelectedSeason(this.selectedSeason);
}

class SetSelectedSeasonEmpty extends SelectedSeasonEvent {}
