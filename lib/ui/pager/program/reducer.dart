import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:lmlive/Constant.dart';
import 'package:lmlive/beans/bean/multiple_entity.dart';
import 'package:lmlive/beans/bean/multiple_type.dart';
import 'package:lmlive/beans/bean/program.dart';
import 'package:lmlive/fish_redux/common_action.dart';
import 'package:lmlive/provider/view_state.dart';
import 'package:lmlive/utils/string_utils.dart';

import 'action.dart';
import 'components/banner_component/state.dart';
import 'components/program_video/state.dart';
import 'components/programcell_component/state.dart';
import 'state.dart';

Reducer<ProgramState> buildReducer() {
  return asReducer(
    <Object, Reducer<ProgramState>>{
      ProgramAction.didLoad: _didLoad,
      CommonAction.error: _error,
      CommonAction.updateView: _updateState,
      ProgramAction.didLoadMore: _didLoadMore,
      ProgramAction.loadMoreError: _loadMoreError
    },
  );
}

//首次加载
ProgramState _didLoad(ProgramState state, Action action) {
  debugPrint('ProgramState _didLoad state=${state.refreshController.hashCode}');
  ProgramData programs = action.payload;
  final ProgramState newState = state.clone();
  newState.viewState = ViewState.idle;
  newState.refreshController.refreshCompleted();
  if (boole(programs.hasMore)) {
    newState.refreshController.loadComplete();
  } else {
    newState.refreshController.loadNoData();
  }
//  var list = List<MultipleEntity>();
  var list = List<MultipleType>();
  if (newState.currentCategory == HomeCategory.RECOMMEND) {
    var recommendList = List<ProgramListListBean>();
    if (programs.programList?.isNotEmpty == true) {
      recommendList.add(programs.programList.removeAt(0));
    }
    if (recommendList.isNotEmpty) {
//      list.add(MultipleEntity(ProgramState.TYPE_VIDEO, recommendList));
      //todo
      debugPrint('newState.ijkMediaController=${newState.ijkMediaController}');
      newState.ijkMediaController = newState.ijkMediaController ?? IjkMediaController(autoRotate: true, needChangeSpeed: false);
      list.add(ProgramVideoState(videoList: recommendList, ijkController: newState.ijkMediaController));
    }
  }
  programs.programList?.forEach((item) {
//    list.add(MultipleEntity(ProgramState.TYPE_PROGRAM, item));
    list.add(ProgramCellState(programBean: item));
  });
  if (programs?.bannerList != null) {
    var size = programs.programList.length;
    var banners = programs.bannerList;
    //容错处理
    if (banners.isNotEmpty) {
      if (newState.currentCategory == HomeCategory.HOT) {
        if (size > ProgramState.BANNER_POSITION) {
//          list.insert(ProgramState.BANNER_POSITION, MultipleEntity(ProgramState.TYPE_BANNER, banners));
          list.insert(ProgramState.BANNER_POSITION, ProgramBannerState(bannerList: banners));
        } else {
//          list.add(MultipleEntity(ProgramState.TYPE_BANNER, banners));
          list.add(ProgramBannerState(bannerList: banners));
        }
      } else {
//        list.insert(0, MultipleEntity(ProgramState.TYPE_BANNER, banners));
        list.insert(0, ProgramBannerState(bannerList: banners));
      }
    }
  }
  //每次重新设置索引位置
  newState.offset += programs.programList.length;
  newState.programs = list;
//  newState.hasMore = boole(programs.hasMore);
//  newState.loadMoreError = false;
  return newState;
}

ProgramState _error(ProgramState state, Action action) {
  debugPrint("错误了：${action.payload}");
  final ProgramState newState = state.clone();
  ViewStateError error = action.payload;
  newState.error = error;
  newState.viewState = ViewState.error;
  return newState;
}

ProgramState _updateState(ProgramState state, Action action) {
  ProgramState newState = state.clone();
  var viewState = action.payload;
  newState.viewState = viewState;
  return newState;
}

//加载更多
ProgramState _didLoadMore(ProgramState state, Action action) {
  ProgramData programs = action.payload;
  final ProgramState newState = state.clone();
  if (boole(programs.hasMore)) {
    newState.refreshController.loadComplete();
  } else {
    newState.refreshController.loadNoData();
  }
//  var list = List<MultipleEntity>();
//  programs.programList?.forEach((item) {
//    list.add(MultipleEntity(ProgramState.TYPE_PROGRAM, item));
//  });
  var list = List<MultipleType>();
  programs.programList?.forEach((item) {
    list.add(ProgramCellState(programBean: item));
  });
  newState.offset += list.length;
  newState.programs.addAll(list);
//  newState.hasMore = boole(programs.hasMore);
//  newState.loadMoreError = false;
  return newState;
}

//加载更多出错
ProgramState _loadMoreError(ProgramState state, Action action) {
  final ProgramState newState = state.clone();
//  newState.loadMoreError = true;
  state.refreshController.loadFailed();
  return newState;
}
