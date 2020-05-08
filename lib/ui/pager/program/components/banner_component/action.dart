import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ProgramBannerAction { action }

class ProgramBannerActionCreator {
  static Action onAction() {
    return const Action(ProgramBannerAction.action);
  }
}
