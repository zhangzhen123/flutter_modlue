import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:lmlive/fish_redux/common_action.dart';
import 'package:lmlive/net/error.dart';
import 'package:lmlive/net/services/live_repository.dart';
import 'package:lmlive/provider/view_state.dart';
import 'package:lmlive/ui/pager/online_treasure_box/award/page.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<OnlineTreasureBoxState> buildEffect() {
  return combineEffects(<Object, Effect<OnlineTreasureBoxState>>{
    Lifecycle.initState: _init,
    OnlineTreasureBoxAction.onFetch: _onFetch,
    OnlineTreasureBoxAction.onReceive: _onReceived,
  });
}

Future<void> _init(Action action, Context<OnlineTreasureBoxState> ctx) async {
  debugPrint("OnlineTreasureBoxState _init");
  ctx.dispatch(CommonActionCreator.updateView(ViewState.busy));
  ctx.dispatch(OnlineTreasureBoxActionCreator.onFetchAction());
}

Future<void> _onFetch(Action action, Context<OnlineTreasureBoxState> ctx) async {
  debugPrint("OnlineTreasureBoxState _onFetch");
//  ctx.dispatch(CommonActionCreator.updateView(ViewState.busy));
  LiveRepository.getOnlineTreasure().then((info) {
    if (info == null) {
      ctx.dispatch(CommonActionCreator.updateView(ViewState.empty));
    } else {
      ctx.dispatch(CommonActionCreator.didLoadAction(info));
    }
  }, onError: (e, s) {
    ctx.dispatch(CommonActionCreator.error(ErrorTodo.setError(e, s)));
  });
}

Future<void> _onReceived(Action action, Context<OnlineTreasureBoxState> ctx) async {
  debugPrint("OnlineTreasureBoxState _onReceived");
  String code = action.payload;
  LiveRepository.saveOnlineTreasure(code).then((award) {
    //领取成功后通知刷新面板
    ctx.dispatch(OnlineTreasureBoxActionCreator.onFetchAction());
    if (award != null) {
      debugPrint("打开领取弹窗 $award");
      showDialog<int>(
          context: ctx.context,
          builder: (BuildContext context) {
            return Dialog(
              child: TreasureBoxAwardPage().buildPage(award),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            );
          });
    }
  }, onError: (e, s) {
    var error = ErrorTodo.setError(e, s);
    showToast("领取出错了 ${error.message}");
  });
}
