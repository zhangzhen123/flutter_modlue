import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ProgramState> buildReducer() {
  return asReducer(
    <Object, Reducer<ProgramState>>{
      ProgramAction.action: _onAction,
    },
  );
}

ProgramState _onAction(ProgramState state, Action action) {
  final ProgramState newState = state.clone();
  return newState;
}
