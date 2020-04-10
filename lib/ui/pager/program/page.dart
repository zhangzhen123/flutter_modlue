import 'package:fish_redux/fish_redux.dart';

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
                adapter: null,
                slots: <String, Dependent<ProgramState>>{
                }),
            middleware: <Middleware<ProgramState>>[
            ],);

}
