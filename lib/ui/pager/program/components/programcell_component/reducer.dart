import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ProgramCellState> buildReducer() {
  return asReducer(
    <Object, Reducer<ProgramCellState>>{
      ProgramCellAction.action: _onAction,
    },
  );
}

ProgramCellState _onAction(ProgramCellState state, Action action) {
  final ProgramCellState newState = state.clone();
  return newState;
}
