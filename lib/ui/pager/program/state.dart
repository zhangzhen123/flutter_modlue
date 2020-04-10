import 'package:fish_redux/fish_redux.dart';

class ProgramState implements Cloneable<ProgramState> {

  @override
  ProgramState clone() {
    return ProgramState();
  }
}

ProgramState initState(Map<String, dynamic> args) {
  return ProgramState();
}
