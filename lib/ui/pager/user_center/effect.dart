import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:lmlive/net/error.dart';
import 'package:lmlive/net/services/user_repository.dart';
import 'package:lmlive/provider/view_state.dart';
import 'action.dart';
import 'state.dart';

Effect<UserCenterState> buildEffect() {
  return combineEffects(<Object, Effect<UserCenterState>>{
    Lifecycle.initState: _init,
    UserCenterAction.onFetch: _init,
    Lifecycle.dispose: _dispose
  });
}

Future<void> _init(Action action, Context<UserCenterState> ctx) async {
  debugPrint("UserCenterState _init");
  String sessionId = ctx.state.sessionId;
//  try {
//    UserInfo info = await AppRepository.queryUserDetailInfo(sessionId);
//    if (info == null) {
//      ctx.dispatch(UserCenterActionCreator.updateView(ViewState.empty));
//    } else {
//      ctx.dispatch(UserCenterActionCreator.didLoadAction(info));
//    }
//  } catch (e, s) {
//    setError(e, s);
//    ctx.dispatch(UserCenterActionCreator.updateView(ViewState.error));
//  }
  ctx.dispatch(UserCenterActionCreator.updateView(ViewState.busy));
  UserRepository.queryUserDetailInfo(sessionId).then((info) {
    if (info == null) {
      ctx.dispatch(UserCenterActionCreator.updateView(ViewState.empty));
    } else {
      ctx.dispatch(UserCenterActionCreator.didLoadAction(info));
    }
  }, onError: (e, s) {
    ctx.dispatch(UserCenterActionCreator.error(ErrorTodo.setError(e, s)));
  });
}

void _dispose(Action action, Context<UserCenterState> ctx) async {
  debugPrint("UserCenterState _dispose");
  ctx.state.refreshController.dispose();
}
