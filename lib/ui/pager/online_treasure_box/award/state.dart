import 'package:fish_redux/fish_redux.dart';
import 'package:lmlive/beans/bean/tresure_box_award.dart';

class TreasureBoxAwardState implements Cloneable<TreasureBoxAwardState> {
  TreasureBoxAward award;

  @override
  TreasureBoxAwardState clone() {
    return TreasureBoxAwardState()..award = award;
  }
}

TreasureBoxAwardState initState(TreasureBoxAward award) {
  return TreasureBoxAwardState()..award = award;
}
