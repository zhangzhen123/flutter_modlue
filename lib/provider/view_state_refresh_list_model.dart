import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:lmlive/beans/base/RootListData.dart';
import 'package:lmlive/utils/string_utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'view_state_list_model.dart';
import 'package:lmlive/extensions.dart';

/// 基于
abstract class ViewStateRefreshListModel<T> extends ViewStateListModel<T> {
  /// 拉取数据开始的位置
  static const int offsetFirst = 0;

  /// 分页条目数量

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  /// 当前页码
  int _offset = 0;

  /// 下拉刷新
  ///
  /// [init] 是否是第一次加载
  /// true:  Error时,需要跳转页面
  /// false: Error时,不需要跳转页面,直接给出提示
  Future<RootListData<T>> refresh({bool init = false}) async {
    try {
      _offset = offsetFirst;
      var data = await loadData(offset: _offset);
      _offset = data.list.length;
      if (data.list.isEmpty) {
        refreshController.refreshCompleted(resetFooterState: true);
        list.clear();
        setEmpty();
      } else {
        onCompleted(data);
        list.clear();
        list.addAll(data.list);
        refreshController.refreshCompleted();
        // 没有更多数据,禁止上拉加载更多
        if (!boole(data.hasMore)) {
          refreshController.loadNoData();
        } else {
          //防止上次上拉加载更多失败,需要重置状态
          refreshController.loadComplete();
        }
        setIdle();
      }
      return data;
    } catch (e, s) {
      /// 页面已经加载了数据,如果刷新报错,不应该直接跳转错误页面
      /// 而是显示之前的页面数据.给出错误提示
      if (init) list.clear();
      refreshController.refreshFailed();
      setError(e, s);
      return null;
    }
  }

  /// 上拉加载更多
  Future<RootListData<T>> loadMore() async {
    try {
      var data = await loadData(offset: _offset);
      _offset += data.list.length;
      if (data.list.isEmpty) {
        refreshController.loadNoData();
      } else {
        onCompleted(data);
        list.addAll(data.list);
        if (!data.hasMore.boolean) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
        notifyListeners();
      }
      return data;
    } catch (e, s) {
      refreshController.loadFailed();
      debugPrint('error--->\n' + e.toString());
      debugPrint('statck--->\n' + s.toString());
      return null;
    }
  }

  // 加载数据
  Future<RootListData<T>> loadData({int offset});

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
