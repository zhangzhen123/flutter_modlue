import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ProgramCellAction { action }

class ProgramCellActionCreator {
  static Action onAction() {
    return const Action(ProgramCellAction.action, payload: "www");
  }
}
