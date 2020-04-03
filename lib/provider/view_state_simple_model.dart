import 'view_state_model.dart';

/// 最简单的数据模型  单一数据处理
abstract class ViewStateSimpleModel<T> extends ViewStateModel {
  /// 页面数据
  T data;

  initData() async {
    setBusy();
    try {
      data = await loadData();
      if (data == null) {
        setEmpty();
      } else {
        onCompleted(data);
        setIdle();
      }
    } catch (e, s) {
      data = null;
      setError(e, s);
    }
  }

  // 加载数据
  Future<T> loadData();

  onCompleted(T data) {}
}
