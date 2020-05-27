import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:lmlive/config/resource_mananger.dart';
import 'package:lmlive/res/color.dart';
import 'package:lmlive/ui/pager/program/page.dart';
import 'package:lmlive/ui/widget/KeepAliveWidget.dart';
import 'package:lmlive/view_model/app_model.dart';
import 'package:provider/provider.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(HomePagerState state, Dispatch dispatch, ViewService viewService) {
  var typeList = state.homePageTab?.homeCategories ?? [];
  return DefaultTabController(
    child: Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          leading: FlatButton(
            padding: EdgeInsets.all(10),
            onPressed: () {
              //todo 跳转查询页
              dispatch(HomePagerActionCreator.onSearchAction());
            },
            child: Container(
              child: Image.asset(ImageHelper.wrapAssets('lm_core_icon_home_page_search.png')),
              width: 25,
              height: 25,
            ),
          ),
          titleSpacing: 1,
          actions: [
            Stack(
              children: <Widget>[
                Container(
                  width: 40,
                  child: FlatButton(
                    onPressed: () {
                      dispatch(HomePagerActionCreator.gotoMessageAction());
                    },
                    padding: EdgeInsets.all(8),
                    child: Image.asset(ImageHelper.wrapAssets('lm_core_icon_message.png')),
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 2,
                  child: Offstage(
                    offstage: state?.messageCount == null || state.messageCount == 0,
                    child: Container(
                      padding: EdgeInsets.only(left: 4, top: 1, right: 4, bottom: 1),
                      decoration: ShapeDecoration(
                        color: Colors.red,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                      ),
                      child: Text(
                        '${state?.messageCount}',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Offstage(
              offstage: !Provider.of<AppModel>(viewService.context).isSdk,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.payment),
              ),
            )
          ],
          centerTitle: true,
          title: TabBar(
              isScrollable: true,
              unselectedLabelColor: LmColors.black_999,
              labelColor: LmColors.black_333,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
              indicatorColor: LmColors.theme_color,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 5),
//              labelPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: List.generate(
                  typeList.length,
                  (index) => Tab(
                        text: typeList.elementAt(index).typeName,
                      ))),
        ),
        preferredSize: Size(double.infinity, 50),
      ),
      body: TabBarView(
        children: List.generate(
            typeList.length, (index) => KeepAliveWidget(ProgramPage().buildPage({"category": typeList[index].typeCode}))),
      ),
    ),
    length: typeList.length,
  );
}
