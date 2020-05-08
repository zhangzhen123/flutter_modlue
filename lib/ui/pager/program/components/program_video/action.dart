import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ProgramVideoAction { action }

class ProgramVideoActionCreator {
  static Action onAction() {
    return const Action(ProgramVideoAction.action);
  }
}
