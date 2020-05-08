import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ProgramCellState> buildEffect() {
  return combineEffects(<Object, Effect<ProgramCellState>>{
    ProgramCellAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ProgramCellState> ctx) {
}
