import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ProgramState> buildEffect() {
  return combineEffects(<Object, Effect<ProgramState>>{
    ProgramAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ProgramState> ctx) {}
