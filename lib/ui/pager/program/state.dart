import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:lmlive/beans/bean/multiple_entity.dart';
import 'package:lmlive/beans/bean/multiple_type.dart';
import 'package:lmlive/provider/view_state.dart';
import 'package:lmlive/ui/pager/program/components/banner_component/state.dart';
import 'package:lmlive/ui/pager/program/components/program_video/state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'components/programcell_component/state.dart';

class ProgramState extends MutableSource implements Cloneable<ProgramState> {
  static const String TYPE_PROGRAM = "program";
  static const String TYPE_BANNER = "banner";
  static const String TYPE_VIDEO = "video";
  static const int BANNER_POSITION = 6;
  static const int LIMIT = 20;

  String currentCategory = '';

//  List<MultipleEntity> programs = [];
  List<MultipleType> programs = [];
  int offset = 0;

  //发现这里用不到 因为刷新控制器也在这里
//  bool hasMore = true;
//  bool loadMoreError = false;
  RefreshController refreshController;

  //这个播放控制器全页面唯一 懒加载 复用
  IjkMediaController ijkMediaController;
  ViewState viewState = ViewState.idle;
  ViewStateError error;

  @override
  ProgramState clone() {
    return ProgramState()
      ..programs = programs
      ..currentCategory = currentCategory
      ..offset = offset
//      ..hasMore = hasMore
      ..refreshController = refreshController
      ..viewState = viewState
      ..error = error
      ..ijkMediaController = ijkMediaController;
  }

  @override
  Object getItemData(int index) {
    return programs[index];
//    String type = programs[index].type;
//    var content = programs[index].content;
//
//    switch (type) {
//      case TYPE_VIDEO:
//        {
//          return ProgramVideoState(videoList: content, ijkController: ijkMediaController);
//        }
//      case TYPE_PROGRAM:
//        {
//          return ProgramCellState(programBean: content);
//        }
//      case TYPE_BANNER:
//        {
//          return ProgramBannerState(bannerList: content);
//        }
//    }
//    return ProgramCellState(programBean: content);
  }

  @override
  String getItemType(int index) {
    return programs[index].type;
  }

  @override
  int get itemCount => programs.length;

  @override
  void setItemData(int index, Object data) {
    // TODO: implement setItemData
  }
}

//初始化时传入当前页的分类code
ProgramState initState(Map<String, dynamic> args) {
  var category = args['category'];
  var state = ProgramState()
    ..currentCategory = category
    ..refreshController = RefreshController(initialRefresh: false);
  debugPrint('ProgramState initState=${state.refreshController.hashCode}');
  return state;
}
