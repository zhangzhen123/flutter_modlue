import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lmlive/provider/view_state.dart';
import 'package:lmlive/provider/view_state_widget.dart';
import 'package:lmlive/ui/pager/online_treasure_box/action.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'action.dart';
import 'state.dart';

const double HOME_SPACE = 5.0;

Widget buildView(ProgramState state, Dispatch dispatch, ViewService viewService) {
  final ListAdapter listAdapter = viewService.buildAdapter();
  return new Scaffold(
    appBar: new AppBar(
      title: new Text('首页数据'),
    ),
    body: new Padding(
      padding: const EdgeInsets.all(HOME_SPACE),
      child: Builder(
        builder: (context) {
          switch (state.viewState) {
            case ViewState.busy:
              {
                debugPrint("当前正忙。。。");
                return ViewStateBusyWidget();
              }
            case ViewState.error:
              {
                return ViewStateErrorWidget(
                  error: state.error,
                  onPressed: () {
                    dispatch(OnlineTreasureBoxActionCreator.onFetchAction());
                  },
                );
              }
            case ViewState.empty:
              {
                return ViewStateEmptyWidget(
                  message: '空空如也',
                  onPressed: () {},
                );
              }
            default:
              {
                return SmartRefresher(
                  onRefresh: () {
                    dispatch(ProgramActionCreator.onFetchAction());
                  },
                  controller: state.refreshController,
                  header: WaterDropHeader(),
                  onLoading: () {
                    debugPrint('onLoading');
                    dispatch(ProgramActionCreator.onFetchMoreAction());
                  },
                  enablePullUp: true,
                  child: new StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: listAdapter.itemCount,
                    itemBuilder: listAdapter
                        .itemBuilder /*(BuildContext context, int index) => new Container(
                color: Colors.green,
                child: new Center(
                  child: new CircleAvatar(
                    backgroundColor: Colors.white,
                    child: new Text('$index'),
                  ),
                ))*/
                    ,
                    staggeredTileBuilder: (int index) {
                      var type = state.getItemType(index);
//            debugPrint("$index 我是$type类型");
                      switch (type) {
                        case ProgramState.TYPE_PROGRAM:
                          {
                            return StaggeredTile.count(1, 1);
                          }
                        case ProgramState.TYPE_BANNER:
                          {
                            debugPrint("我是banner类型");
                            return StaggeredTile.count(2, 0.78);
                          }
                        case ProgramState.TYPE_VIDEO:
                          {
                            return StaggeredTile.count(2, 2);
                          }
                        default:
                          {
                            return StaggeredTile.count(1, 1);
                          }
                      }
                    },
                    mainAxisSpacing: HOME_SPACE,
                    crossAxisSpacing: HOME_SPACE,
                  ),
                );
              }
          }
        },
      ),
    ),
  );
}
