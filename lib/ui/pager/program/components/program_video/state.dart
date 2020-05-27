import 'package:fish_redux/fish_redux.dart';
import 'package:lmlive/beans/bean/program.dart';

class ProgramVideoState implements Cloneable<ProgramVideoState> {
  List<ProgramListListBean> videoList;

  ProgramVideoState({this.videoList});

  @override
  ProgramVideoState clone() {
    return ProgramVideoState()..videoList = videoList;
  }
}

ProgramVideoState initState(Map<String, dynamic> args) {
  return ProgramVideoState();
}
