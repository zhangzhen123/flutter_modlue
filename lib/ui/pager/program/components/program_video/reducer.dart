import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:lmlive/beans/bean/program.dart';

import 'action.dart';
import 'state.dart';

Reducer<ProgramVideoState> buildReducer() {
  return asReducer(
    <Object, Reducer<ProgramVideoState>>{},
  );
}
