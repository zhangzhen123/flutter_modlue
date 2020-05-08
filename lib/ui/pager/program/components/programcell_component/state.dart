import 'package:fish_redux/fish_redux.dart';
import 'package:lmlive/beans/bean/program.dart';

class ProgramCellState implements Cloneable<ProgramCellState> {
  ProgramListListBean programBean;
  ProgramCellState({this.programBean});
  @override
  ProgramCellState clone() {
    return ProgramCellState()..programBean = programBean;
  }
}

ProgramCellState initState(Map<String, dynamic> args) {
  return ProgramCellState();
}
