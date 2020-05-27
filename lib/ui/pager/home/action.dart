import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum HomePagerAction { action, searchAction, gotoMessage }

class HomePagerActionCreator {
  static Action onAction() {
    return const Action(HomePagerAction.action);
  }

  static Action onSearchAction() {
    return const Action(HomePagerAction.searchAction);
  }

  static Action gotoMessageAction() {
    return const Action(HomePagerAction.gotoMessage);
  }
}
