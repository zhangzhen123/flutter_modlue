import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ProgramBannerState> buildReducer() {
  return asReducer(
    <Object, Reducer<ProgramBannerState>>{
      ProgramBannerAction.action: _onAction,
    },
  );
}

ProgramBannerState _onAction(ProgramBannerState state, Action action) {
  final ProgramBannerState newState = state.clone();
  return newState;
}
