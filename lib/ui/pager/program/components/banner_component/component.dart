import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ProgramBannerComponent extends Component<ProgramBannerState> {
  ProgramBannerComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ProgramBannerState>(
                adapter: null,
                slots: <String, Dependent<ProgramBannerState>>{
                }),);

}
