import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ProgramVideoState> buildEffect() {
  return combineEffects(<Object, Effect<ProgramVideoState>>{
    ProgramVideoAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ProgramVideoState> ctx) {
}
