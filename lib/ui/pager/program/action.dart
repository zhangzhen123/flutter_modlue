import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ProgramAction { action }

class ProgramActionCreator {
  static Action onAction() {
    return const Action(ProgramAction.action);
  }
}
