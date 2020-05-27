import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action hide Page;

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class OnlineTreasureBoxPage extends Page<OnlineTreasureBoxState, Map<String, dynamic>> {
  OnlineTreasureBoxPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies:
                Dependencies<OnlineTreasureBoxState>(adapter: null, slots: <String, Dependent<OnlineTreasureBoxState>>{}),
            middleware: <Middleware<OnlineTreasureBoxState>>[],
            effectMiddleware: <EffectMiddleware<OnlineTreasureBoxState>>[_pageAnalyticsMiddleware()],
            viewMiddleware: <ViewMiddleware<OnlineTreasureBoxState>>[testViewMiddleware()]);
}

Widget error(dynamic e, StackTrace s, {AbstractComponent<dynamic> component, Store store}) {
  debugPrint("我是错误信息的中间件：$e  s=$s");
  return Container(
    child: Text("$e"),
  );
}

ViewMiddleware<T> testViewMiddleware<T>(
    {Widget Function(dynamic, StackTrace, {AbstractComponent<dynamic> component, Store<T> store}) onError}) {
  print('我是ViewMiddleware ');
  return (AbstractComponent<dynamic> component, Store<T> store) {
    print('我是ViewMiddleware component=${component.runtimeType}  ');
    return (ViewBuilder<dynamic> next) {
      print('我是ViewMiddleware next=${next.runtimeType}  ');
      return (dynamic state, Dispatch dispatch, ViewService viewService) {
        print('我是ViewMiddleware state=${state.runtimeType} viewState=${state.viewState}  ');
        try {
          return next(state, dispatch, viewService);
        } catch (e, stackTrace) {
          return onError?.call(
                e,
                stackTrace,
                component: component,
                store: store,
              ) ??
              Container(width: 0, height: 0);
        }
      };
    };
  };
}

EffectMiddleware<T> _pageAnalyticsMiddleware<T>() {
  return (AbstractLogic<dynamic> logic, Store<T> store) {
    return (Effect<dynamic> effect) {
      return (Action action, Context<dynamic> ctx) {
        if (logic is Page<dynamic, dynamic> && action.type is Lifecycle) {
          print('我是EffectMiddleware ${logic.runtimeType} ${action.type.toString()} ');
        }
        return effect?.call(action, ctx);
      };
    };
  };
}
