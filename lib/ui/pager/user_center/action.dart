import 'package:fish_redux/fish_redux.dart';
import 'package:lmlive/beans/bean/user_info.dart';

enum UserCenterAction { doLoad }

class UserCenterActionCreator {
  static Action doLoadAction(UserInfo userInfo) {
    return Action(UserCenterAction.doLoad, payload: userInfo);
  }
}
