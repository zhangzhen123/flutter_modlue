import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lmlive/provider/provider_widget.dart';
import 'package:lmlive/res/color.dart';
import 'package:lmlive/ui/pager/follow/follow_pager.dart';
import 'package:lmlive/ui/pager/home/page.dart';
import 'package:lmlive/ui/pager/user_center/page.dart';
import 'package:lmlive/ui/widget/KeepAliveWidget.dart';
import 'package:lmlive/view_model/main_model.dart';
import 'package:lottie/lottie.dart';

class MainPager extends StatefulWidget {
  @override
  _MainPagerState createState() => _MainPagerState();
}

class _MainPagerState extends State<MainPager> with TickerProviderStateMixin {
  bool publish = false; //todo
  int _position = 0;
  final tabMap = LinkedHashMap.from({
    '直播': 'assets/json/home_homepage.json',
    '广场': 'assets/json/home_publicsquare.json',
    '关注': 'assets/json/home_attention.json',
    '我的': 'assets/json/home_mine.json'
  });
  List<AnimationController> _controllers = [];
  var _pageController = PageController();

  @override
  void initState() {
    //遍历生成需要的动画控制器
    tabMap.forEach((_, v) {
      _controllers.add(AnimationController(vsync: this));
    });
    super.initState();
  }

  @override
  void dispose() {
    _controllers.forEach((item) => item.dispose());
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var list = tabMap.keys.toList();
    return ProviderWidget<MainModel>(
      model: MainModel(),
      onModelReady: (model) {
        debugPrint('onModelReady');
        model.initData();
      },
      builder: (context, model, child) {
        return Scaffold(
          body: SafeArea(
            child: PageView.builder(
              itemBuilder: (ctx, index) {
                var item = list[index];
                switch (item) {
                  case "直播":
                    return KeepAliveWidget(HomePagerPage().buildPage(null));
                  case "广场":
                    return KeepAliveWidget(Center(child: Text('广场')));
                  case "关注":
                    return KeepAliveWidget(FollowPager());
                  case "我的":
                    return KeepAliveWidget(UserCenterPage().buildPage(null));
                  default:
                    return Text('不存在的页面');
                }
              },
              itemCount: list.length,
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            elevation: 1,
            shape: CircularNotchedRectangle(),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: list
                  .map(
                    (e) => _buildChild(context, list.indexOf(e)),
                  )
                  .toList(),
            ),
          ),
          floatingActionButton: publish
              ? FloatingActionButton(
                  onPressed: () {
                    debugPrint('开始直播');
                  },
                  child: Icon(
                    Icons.add,
                  ))
              : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }

  Widget _buildChild(BuildContext context, int index) {
    var active = index == _position;
    String title = tabMap.keys.elementAt(index);
    String assets = tabMap.values.elementAt(index);
    return GestureDetector(
      onTap: () => _tapTab(index),
      child: Container(
        height: 49,
        width: 80,
        child: OverflowBox(
          alignment: Alignment.bottomCenter,
          maxHeight: 70,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                bottom: 15,
                child: Lottie.asset(assets, width: 136, height: 47, repeat: false, animate: true, controller: _controllers[index],
                    onLoaded: (composition) {
                  setState(() {
                    debugPrint('composition.duration=${composition.duration}');
                    _controllers[index].duration = composition.duration;
                    if (active) {
                      _controllers[index].forward();
                    }
                  });
                }),
              ),
              Positioned(
                  bottom: 1,
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 10, color: active ? LmColors.black_333 : LmColors.black_999),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  _tapTab(int i) {
    debugPrint('我点击了第$i 个');
    _pageController.jumpToPage(i);
    setState(() {
      _position = i;
      var ani = _controllers[i];
      _controllers.forEach((item) {
        if (ani == item) {
          item.forward(from: 0);
        } else {
          item.reset();
        }
      });
    });
  }
}
