import 'package:bloc_test/bloc_test.dart';
import 'package:series/presentation/bloc/selected_season_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SelectedSeasonBloc selectedSeasonBloc;

  setUp(
    () {
      selectedSeasonBloc = SelectedSeasonBloc();
    },
  );

  test(
    'initial state should be empty',
    () {
      expect(selectedSeasonBloc.state, SelectedSeasonEmpty());
    },
  );

  blocTest<SelectedSeasonBloc, SelectedSeasonState>(
    'Should emit [HasData] when data is gotten successfully',
    build: () {
      return selectedSeasonBloc;
    },
    act: (bloc) => bloc.add(SelectedSeason(1)),
    expect: () => [
      SelectedSeasonHasData(1),
    ],
  );

  blocTest<SelectedSeasonBloc, SelectedSeasonState>(
    'Should emit [Empty] when data is empty',
    build: () {
      return selectedSeasonBloc;
    },
    act: (bloc) => bloc.add(SetSelectedSeasonEmpty()),
    expect: () => [
      SelectedSeasonEmpty(),
    ],
  );
}
