import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:lmlive/beans/bean/user_info.dart';

import 'action.dart';
import 'state.dart';

Reducer<UserCenterState> buildReducer() {
  return asReducer(
    <Object, Reducer<UserCenterState>>{
      UserCenterAction.doLoad: loadInfo,
    },
  );
}

UserCenterState loadInfo(UserCenterState state, Action action) {
  debugPrint("获取到了用户信息：${action.payload}");
  final UserCenterState newState = state.clone();
  UserInfo info = action.payload;
  newState.userInfo = info;
  return newState;
}
