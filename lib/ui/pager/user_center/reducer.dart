import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:lmlive/beans/bean/user_info.dart';
import 'package:lmlive/provider/view_state.dart';

import 'action.dart';
import 'state.dart';

Reducer<UserCenterState> buildReducer() {
  return asReducer(
    <Object, Reducer<UserCenterState>>{
//      UserCenterAction.onFetch: _onFetch,
      UserCenterAction.update: _updateState,
      UserCenterAction.didLoad: _loadInfo,
      UserCenterAction.error: _error
    },
  );
}

//UserCenterState _onFetch(UserCenterState state, Action action) {
//  UserCenterState newState = state.clone();
//  newState.viewState = ViewState.busy;
//  return newState;
//}

UserCenterState _updateState(UserCenterState state, Action action) {
  UserCenterState newState = state.clone();
  var viewState = action.payload;
  newState.viewState = viewState;
  return newState;
}

UserCenterState _loadInfo(UserCenterState state, Action action) {
  debugPrint("获取到了用户信息：${action.payload}");
  final UserCenterState newState = state.clone();
  UserInfo info = action.payload;
  newState.userInfo = info;
  newState.viewState = ViewState.idle;
  newState.refreshController.refreshCompleted();
  return newState;
}

UserCenterState _error(UserCenterState state, Action action) {
  debugPrint("错误了：${action.payload}");
  final UserCenterState newState = state.clone();
  ViewStateError error = action.payload;
  newState.error = error;
  newState.viewState = ViewState.error;
  newState.refreshController.refreshFailed();
  return newState;
}
