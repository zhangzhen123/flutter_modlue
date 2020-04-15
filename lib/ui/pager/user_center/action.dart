import 'package:fish_redux/fish_redux.dart';
import 'package:lmlive/beans/bean/user_info.dart';
import 'package:lmlive/provider/view_state.dart';

enum UserCenterAction { onFetch, update, didLoad, error }

class UserCenterActionCreator {
  static Action onFetchAction() {
    return Action(UserCenterAction.onFetch);
  }

  static Action didLoadAction(UserInfo userInfo) {
    return Action(UserCenterAction.didLoad, payload: userInfo);
  }

  static Action updateView(ViewState viewState) {
    return Action(UserCenterAction.update, payload: viewState);
  }

  static Action error(dynamic error) {
    return Action(UserCenterAction.error, payload: error);
  }
}
