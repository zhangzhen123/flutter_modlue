import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:lmlive/Constant.dart';
import 'package:lmlive/res/color.dart';

import 'follow_list_page.dart';

class FollowPager extends StatefulWidget {
  @override
  _FollowPagerState createState() => _FollowPagerState();
}

class _FollowPagerState extends State<FollowPager> with AutomaticKeepAliveClientMixin {
//  List<Pair<String, String>> typeList = [Pair('FOLLOW', '关注'), Pair('GUARD', '守护'), Pair('MANAGER', '管理'), Pair('SEE', '看过')];
  LinkedHashMap<String, String> typeList = LinkedHashMap.from(
      {FollowPageType.FOLLOW: '关注', FollowPageType.GUARD: '守护', FollowPageType.MANAGER: '管理', FollowPageType.SEE: '看过'});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            automaticallyImplyLeading: false,
            leading: null,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: TabBar(
                isScrollable: true,
                unselectedLabelColor: LmColors.black_999,
                labelColor: LmColors.black_333,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                indicatorColor: LmColors.theme_color,
                indicatorPadding: EdgeInsets.symmetric(horizontal: 5),
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: List.generate(
                    typeList.length,
                    (index) => Tab(
                          text: typeList.values.elementAt(index),
                        ))),
          ),
          preferredSize: Size(double.infinity, 60),
        ),
        body: TabBarView(
          children: List.generate(typeList.length, (index) => FollowListPage(typeList.keys.elementAt(index))),
        ),
      ),
      length: typeList.length,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
