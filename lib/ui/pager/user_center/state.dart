import 'package:fish_redux/fish_redux.dart';
import 'package:lmlive/beans/bean/user_info.dart';
import 'package:lmlive/provider/view_state.dart';
import 'package:lmlive/utils/session_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserCenterState implements Cloneable<UserCenterState> {
  ViewState viewState = ViewState.idle;
  ViewStateError error;
  String sessionId;
  UserInfo userInfo;
  RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  UserCenterState clone() {
    return UserCenterState()
      ..sessionId = sessionId
      ..userInfo = userInfo
      ..viewState = viewState
      ..error = error
      ..refreshController = refreshController;
  }
}

UserCenterState initState(Map<String, dynamic> args) {
  return UserCenterState()..sessionId = SessionUtils.instance.getSessionId();
}
