import 'package:fish_redux/fish_redux.dart';

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
