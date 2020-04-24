import 'package:fish_redux/fish_redux.dart';
import 'package:lmlive/beans/bean/treasure_box_info.dart';
import 'package:lmlive/provider/view_state.dart';

class OnlineTreasureBoxState implements Cloneable<OnlineTreasureBoxState> {
  ViewState viewState = ViewState.idle;
  ViewStateError error;
  TreasureBoxInfo mTreasureBoxInfo;

  @override
  OnlineTreasureBoxState clone() {
    return OnlineTreasureBoxState()
      ..viewState = viewState
      ..error = error
      ..mTreasureBoxInfo = mTreasureBoxInfo;
  }
}

OnlineTreasureBoxState initState(Map<String, dynamic> args) {
  return OnlineTreasureBoxState();
}
