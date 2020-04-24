import 'package:fish_redux/fish_redux.dart';
import 'package:lmlive/beans/bean/treasure_box_info.dart';
import 'package:lmlive/beans/bean/tresure_box_award.dart';
import 'package:lmlive/provider/view_state.dart';

//TODO replace with your own action
enum OnlineTreasureBoxAction { onFetch /*, updateView, didLoad, detailError*/, onReceive }

class OnlineTreasureBoxActionCreator {
  static Action onFetchAction() {
    return Action(OnlineTreasureBoxAction.onFetch);
  }

  static Action onReceive(String code) {
    return Action(OnlineTreasureBoxAction.onReceive, payload: code);
  }

//  static Action didLoadAction(TreasureBoxInfo info) {
//    return Action(OnlineTreasureBoxAction.didLoad, payload: info);
//  }
//
//  static Action updateView(ViewState viewState) {
//    return Action(OnlineTreasureBoxAction.updateView, payload: viewState);
//  }
//
//  static Action detailError(dynamic error) {
//    return Action(OnlineTreasureBoxAction.detailError, payload: error);
//  }
}
