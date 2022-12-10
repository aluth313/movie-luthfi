import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'selected_season_event.dart';
part 'selected_season_state.dart';

class SelectedSeasonBloc
    extends Bloc<SelectedSeasonEvent, SelectedSeasonState> {
  SelectedSeasonBloc() : super(SelectedSeasonEmpty()) {
    on<SelectedSeason>((event, emit) {
      // emit(SelectedSeasonEmpty());
      emit(
        SelectedSeasonHasData(event.selectedSeason),
      );
    });

    on<SetSelectedSeasonEmpty>((event, emit) {
      emit(SelectedSeasonEmpty());
    });
  }
}
