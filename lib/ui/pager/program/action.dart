import 'package:fish_redux/fish_redux.dart';
import 'package:lmlive/beans/bean/program.dart';

enum ProgramAction { onFetch, onFetchMore, didLoad, didLoadMore, loadMoreError }

class ProgramActionCreator {
  //代表第一次去取
  static Action onFetchAction() {
    return const Action(ProgramAction.onFetch);
  }

  static Action onFetchMoreAction() {
    return const Action(ProgramAction.onFetchMore);
  }

  //代表第一次返回的结果
  static Action didLoadAction(ProgramData data) {
    return Action(ProgramAction.didLoad, payload: data);
  }

  static Action didLoadMoreAction(ProgramData data) {
    return Action(ProgramAction.didLoadMore, payload: data);
  }

  //下拉加载更多出错的通知
  static Action loadMoreErrorAction() {
    return Action(ProgramAction.loadMoreError);
  }
}
