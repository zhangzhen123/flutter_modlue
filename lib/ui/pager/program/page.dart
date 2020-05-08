import 'package:fish_redux/fish_redux.dart';
import 'package:lmlive/ui/pager/program/adapter/adapter.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ProgramPage extends Page<ProgramState, Map<String, dynamic>> {
  ProgramPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ProgramState>(
              adapter: NoneConn<ProgramState>() + ProgramAdapter(), slots: <String, Dependent<ProgramState>>{}),
          middleware: <Middleware<ProgramState>>[],
        );
}
