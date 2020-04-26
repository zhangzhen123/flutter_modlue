import 'package:fish_redux/fish_redux.dart';
import 'package:lmlive/beans/bean/tresure_box_award.dart';

import 'state.dart';
import 'view.dart';

class TreasureBoxAwardPage extends Page<TreasureBoxAwardState, TreasureBoxAward> {
  TreasureBoxAwardPage()
      : super(
          initState: initState,
          view: buildView,
          dependencies: Dependencies<TreasureBoxAwardState>(adapter: null, slots: <String, Dependent<TreasureBoxAwardState>>{}),
          middleware: <Middleware<TreasureBoxAwardState>>[],
        );
}
