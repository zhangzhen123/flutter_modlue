import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ProgramBannerState> buildEffect() {
  return combineEffects(<Object, Effect<ProgramBannerState>>{
    ProgramBannerAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ProgramBannerState> ctx) {
}
