import 'package:fish_redux/fish_redux.dart';
import 'package:lmlive/beans/bean/findnews.dart';
import 'package:lmlive/provider/view_state.dart';

class HomePagerState implements Cloneable<HomePagerState> {
  ViewState viewState = ViewState.idle;
  ViewStateError error;

  HomePageTab homePageTab;
  //todo
  int messageCount = 0;

  @override
  HomePagerState clone() {
    return HomePagerState()
      ..viewState = viewState
      ..error = error
      ..homePageTab = homePageTab
      ..messageCount = messageCount;
  }
}

HomePagerState initState(Map<String, dynamic> args) {
  return HomePagerState();
}
