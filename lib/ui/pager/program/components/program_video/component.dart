import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ProgramVideoComponent extends Component<ProgramVideoState> {
  ProgramVideoComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            var diff = oldState.video != null && oldState.video?.programId != newState.video?.programId;
            debugPrint("oldState=${oldState.video.hashCode} newState=${newState.video.hashCode} diff=$diff");
            return diff;
          },
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ProgramVideoState>(adapter: null, slots: <String, Dependent<ProgramVideoState>>{}),
        );
}
