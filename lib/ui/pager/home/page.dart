import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class HomePagerPage extends Page<HomePagerState, Map<String, dynamic>> {
  HomePagerPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<HomePagerState>(
                adapter: null,
                slots: <String, Dependent<HomePagerState>>{
                }),
            middleware: <Middleware<HomePagerState>>[
            ],);

}
