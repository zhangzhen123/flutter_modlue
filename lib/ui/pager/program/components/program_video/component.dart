import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ProgramVideoComponent extends Component<ProgramVideoState> {
  ProgramVideoComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ProgramVideoState>(
                adapter: null,
                slots: <String, Dependent<ProgramVideoState>>{
                }),);

}
