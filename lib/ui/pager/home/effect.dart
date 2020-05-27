import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:lmlive/beans/bean/findnews.dart';
import 'package:lmlive/fish_redux/common_action.dart';
import 'package:lmlive/ui/pager/home/action.dart';
import 'package:lmlive/view_model/app_model.dart';
import 'package:provider/provider.dart';
import 'state.dart';

var localTabList = [
  ProgramTab(typeCode: 'Recom', typeName: '推荐'),
  ProgramTab(typeCode: 'Hot', typeName: '热门'),
  ProgramTab(typeCode: 'New', typeName: '新秀'),
  ProgramTab(typeCode: 'Dancer', typeName: '舞神'),
  ProgramTab(typeCode: 'Singer', typeName: '唱将'),
  ProgramTab(typeCode: 'Funny', typeName: '娱乐')
];

Effect<HomePagerState> buildEffect() {
  return combineEffects(<Object, Effect<HomePagerState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
    HomePagerAction.searchAction: _onSearch,
    HomePagerAction.gotoMessage: _gotoMessage
  });
}

Future<void> _init(Action action, Context<HomePagerState> ctx) async {
  debugPrint("HomePagerState _init");
  //开始从本地去取存储的首页分类数据 取不到就使用默认的
  var tabsInfo = Provider.of<AppUpdateModel>(ctx.context, listen: false).getTabsInfo();
  debugPrint('tabsInfo=${tabsInfo.homeCategories}');
  if (tabsInfo == null) {
    tabsInfo = HomePageTab(homeCategories: localTabList);
  }
  ctx.dispatch(CommonActionCreator.didLoadAction(tabsInfo));
}

void _onSearch(Action action, Context<HomePagerState> ctx) async {
  debugPrint("HomePagerState _onSearch");
  //todo
}
void _gotoMessage(Action action, Context<HomePagerState> ctx) async {
  debugPrint("HomePagerState _gotoMessage");
  //todo
}
void _dispose(Action action, Context<HomePagerState> ctx) async {
  debugPrint("HomePagerState _dispose");
}
