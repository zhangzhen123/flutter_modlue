import 'package:fish_redux/fish_redux.dart';
import 'package:lmlive/beans/bean/multiple_type.dart';
import 'package:lmlive/beans/bean/program.dart';
import 'package:lmlive/ui/pager/program/state.dart';

class ProgramCellState extends MultipleType  implements Cloneable<ProgramCellState> {
  ProgramListListBean programBean;
  ProgramCellState({this.programBean});
  @override
  ProgramCellState clone() {
    return ProgramCellState()..programBean = programBean;
  }

  @override
  String get type => ProgramState.TYPE_PROGRAM;
}

//ProgramCellState initState(Map<String, dynamic> args) {
//  return ProgramCellState();
//}
