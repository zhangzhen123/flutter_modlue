import 'package:fish_redux/fish_redux.dart';
import 'package:lmlive/beans/bean/user_info.dart';
import 'package:lmlive/utils/session_utils.dart';

class UserCenterState implements Cloneable<UserCenterState> {
  String sessionId;
  UserInfo userInfo;
  @override
  UserCenterState clone() {
    return UserCenterState();
  }
}

UserCenterState initState(Map<String, dynamic> args) {
  return UserCenterState()..sessionId = SessionUtils.instance.getSessionId();
}
