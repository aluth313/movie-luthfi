part of 'selected_season_bloc.dart';

abstract class SelectedSeasonEvent extends Equatable {
  const SelectedSeasonEvent();

  @override
  List<Object> get props => [];
}

class SelectedSeason extends SelectedSeasonEvent {
  final int selectedSeason;

  SelectedSeason(this.selectedSeason);

  @override
  List<Object> get props => [selectedSeason];
}

class SetSelectedSeasonEmpty extends SelectedSeasonEvent {}
