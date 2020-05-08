import 'package:fish_redux/fish_redux.dart';
import 'package:lmlive/beans/bean/program.dart';

class ProgramVideoState implements Cloneable<ProgramVideoState> {
  ProgramListListBean programBean;

  ProgramVideoState({this.programBean});

  @override
  ProgramVideoState clone() {
    return ProgramVideoState()..programBean = programBean;
  }
}

ProgramVideoState initState(Map<String, dynamic> args) {
  return ProgramVideoState();
}
