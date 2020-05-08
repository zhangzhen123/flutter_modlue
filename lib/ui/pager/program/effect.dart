import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:lmlive/fish_redux/common_action.dart';
import 'package:lmlive/net/error.dart';
import 'package:lmlive/net/services/program_repository.dart';
import 'package:lmlive/provider/view_state.dart';
import 'action.dart';
import 'state.dart';

Effect<ProgramState> buildEffect() {
  return combineEffects(<Object, Effect<ProgramState>>{
    Lifecycle.initState: _init,
    ProgramAction.onFetch: _onFetch,
    ProgramAction.onFetchMore: _onFetchMore,
    Lifecycle.dispose: _onDispose
  });
}

Future<void> _init(Action action, Context<ProgramState> ctx) async {
  debugPrint("ProgramState _init");
  ctx.dispatch(CommonActionCreator.updateView(ViewState.busy));
  ctx.dispatch(ProgramActionCreator.onFetchAction());
}

void _onFetch(Action action, Context<ProgramState> ctx) {
  var state = ctx.state;
  //每次重置offset
  state.offset = 0;
  ProgramRepository.getProgramList(ProgramState.LIMIT, state.currentCategory, state.offset).then((info) {
    if ((info.programList?.isEmpty == true) && (info.bannerList?.isEmpty == true)) {
      ctx.dispatch(CommonActionCreator.updateView(ViewState.empty));
    } else {
      ctx.dispatch(ProgramActionCreator.didLoadAction(info));
    }
  }, onError: (e, s) {
    ctx.dispatch(CommonActionCreator.error(ErrorTodo.setError(e, s)));
  });
}

void _onFetchMore(Action action, Context<ProgramState> ctx) {
  var state = ctx.state;
  debugPrint("加载更多  ${state.offset}");
  ProgramRepository.getProgramList(ProgramState.LIMIT, state.currentCategory, state.offset).then((info) {
    ctx.dispatch(ProgramActionCreator.didLoadMoreAction(info));
  }, onError: (e, s) {
    ctx.dispatch(ProgramActionCreator.loadMoreErrorAction());
  });
}

Future _onDispose(Action action, Context<ProgramState> ctx) async {
  ctx.state.refreshController.dispose();
}
