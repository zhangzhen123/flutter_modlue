import 'package:fish_redux/fish_redux.dart';
import 'package:lmlive/provider/view_state.dart';

///通用的网络请求action
enum CommonAction { updateView, didLoad, error }

class CommonActionCreator {
  static Action didLoadAction(dynamic info) {
    return Action(CommonAction.didLoad, payload: info);
  }

  static Action updateView(ViewState viewState) {
    return Action(CommonAction.updateView, payload: viewState);
  }

  static Action error(dynamic error) {
    return Action(CommonAction.error, payload: error);
  }
}
