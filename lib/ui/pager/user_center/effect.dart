import 'package:fish_redux/fish_redux.dart';
import 'package:lmlive/beans/bean/user_info.dart';
import 'package:lmlive/net/services/app_repository.dart';
import 'action.dart';
import 'state.dart';

Effect<UserCenterState> buildEffect() {
  return combineEffects(<Object, Effect<UserCenterState>>{
    Lifecycle.initState: _init,
  });
}

Future<void> _init(Action action, Context<UserCenterState> ctx) async {
  String sessionId = ctx.state.sessionId;
  UserInfo info = await AppRepository.queryUserDetailInfo(sessionId);
  ctx.dispatch(UserCenterActionCreator.doLoadAction(info));
}
