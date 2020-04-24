import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:lmlive/beans/bean/treasure_box_info.dart';
import 'package:lmlive/fish_redux/common_action.dart';
import 'package:lmlive/provider/view_state.dart';

import 'action.dart';
import 'state.dart';

Reducer<OnlineTreasureBoxState> buildReducer() {
  return asReducer(
    <Object, Reducer<OnlineTreasureBoxState>>{
      CommonAction.updateView: _updateState,
      CommonAction.didLoad: _loadInfo,
      CommonAction.error: _error
    },
  );
}

OnlineTreasureBoxState _updateState(OnlineTreasureBoxState state, Action action) {
  OnlineTreasureBoxState newState = state.clone();
  var viewState = action.payload;
  newState.viewState = viewState;
  return newState;
}

OnlineTreasureBoxState _loadInfo(OnlineTreasureBoxState state, Action action) {
  debugPrint("获取到了宝箱信息：${action.payload}");
  final OnlineTreasureBoxState newState = state.clone();
  TreasureBoxInfo info = action.payload;
  newState.mTreasureBoxInfo = info;
  newState.viewState = ViewState.idle;
  return newState;
}

OnlineTreasureBoxState _error(OnlineTreasureBoxState state, Action action) {
  debugPrint("错误了：${action.payload}");
  final OnlineTreasureBoxState newState = state.clone();
  ViewStateError error = action.payload;
  newState.error = error;
  newState.viewState = ViewState.error;
  return newState;
}
