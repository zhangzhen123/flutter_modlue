import 'package:fish_redux/fish_redux.dart';
import 'package:lmlive/ui/pager/program/components/banner_component/component.dart';
import 'package:lmlive/ui/pager/program/components/program_video/component.dart';
import 'package:lmlive/ui/pager/program/components/programcell_component/component.dart';

import '../state.dart';
import 'reducer.dart';

class ProgramAdapter extends SourceFlowAdapter<ProgramState> {
  ProgramAdapter()
      : super(
          pool: <String, Component<Object>>{
            ProgramState.TYPE_PROGRAM: ProgramCellComponent(),
            ProgramState.TYPE_BANNER: ProgramBannerComponent(),
            ProgramState.TYPE_VIDEO: ProgramVideoComponent()
          },
          reducer: buildReducer(),
        );
}
