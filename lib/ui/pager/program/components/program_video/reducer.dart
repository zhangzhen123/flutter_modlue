import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ProgramVideoState> buildReducer() {
  return asReducer(
    <Object, Reducer<ProgramVideoState>>{
      ProgramVideoAction.action: _onAction,
    },
  );
}

ProgramVideoState _onAction(ProgramVideoState state, Action action) {
  final ProgramVideoState newState = state.clone();
  return newState;
}
