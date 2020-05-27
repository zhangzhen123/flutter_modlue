import 'package:fish_redux/fish_redux.dart';
import 'package:lmlive/beans/bean/findnews.dart';
import 'package:lmlive/fish_redux/common_action.dart';

import 'action.dart';
import 'state.dart';

Reducer<HomePagerState> buildReducer() {
  return asReducer(
    <Object, Reducer<HomePagerState>>{
      HomePagerAction.action: _onAction,
      CommonAction.didLoad: _loadTabs,
    },
  );
}

HomePagerState _onAction(HomePagerState state, Action action) {
  final HomePagerState newState = state.clone();
  return newState;
}

HomePagerState _loadTabs(HomePagerState state, Action action) {
  final HomePagerState newState = state.clone();
  HomePageTab tabs = action.payload;
  newState.homePageTab = tabs;
  return newState;
}
