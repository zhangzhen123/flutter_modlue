import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:lmlive/beans/bean/multiple_type.dart';
import 'package:lmlive/beans/bean/program.dart';
import 'package:lmlive/ui/pager/program/state.dart';

class ProgramVideoState extends MultipleType implements Cloneable<ProgramVideoState> {
  List<ProgramListListBean> videoList;

  ProgramVideoState({this.videoList, this.ijkController}) {
    debugPrint('ProgramVideoState 构造${this.hashCode}  ijk=$ijkController hascode=${this.ijkController.hashCode}');
  }

  ProgramListListBean get video => videoList.isNotEmpty ? videoList[0] : null;

  IjkMediaController ijkController;

  @override
  ProgramVideoState clone() {
    debugPrint('clone ProgramVideoState=$video');
    return ProgramVideoState()
      ..videoList = videoList
      ..ijkController = ijkController;
  }

  @override
  String get type => ProgramState.TYPE_VIDEO;
}

//ProgramVideoState initState(Map<String, dynamic> args) {
//  debugPrint('ProgramVideoState initState');
//  return ProgramVideoState()..ijkController = IjkMediaController();
//}
