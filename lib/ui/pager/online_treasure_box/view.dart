import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lmlive/beans/bean/treasure_box_info.dart';
import 'package:lmlive/config/resource_mananger.dart';
import 'package:lmlive/generated/l10n.dart';
import 'package:lmlive/provider/view_state.dart';
import 'package:lmlive/provider/view_state_widget.dart';
import 'package:lmlive/res/color.dart';
import 'package:lmlive/ui/pager/online_treasure_box/action.dart';
import 'package:lmlive/ui/widget/image.dart';
import 'package:lmlive/utils/time_utils.dart';
import 'package:marquee/marquee.dart';

import 'state.dart';

Widget buildView(OnlineTreasureBoxState state, Dispatch dispatch, ViewService viewService) {
  debugPrint('state=${state.hashCode}');
  ViewState viewState = state.viewState;
  var info = state.mTreasureBoxInfo;
  var treasureList = info?.treasureList;
  return Container(
    alignment: Alignment.bottomCenter,
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage(ImageHelper.wrapAssets("bg_treasure_box.png")), fit: BoxFit.fill),
    ),
    height: 460,
    width: double.infinity,
    child: SafeArea(
      child: Builder(builder: (context) {
        debugPrint('Builder build开始');
        var logString = StringBuffer(" ");

        info?.awardLogList?.forEach((log) {
          logString.write(log);
          logString.write("  ");
        });
//        debugPrint('logString =$logString');
        switch (viewState) {
          case ViewState.busy:
            {
              return ViewStateBusyWidget();
            }
          case ViewState.error:
            {
              return ViewStateErrorWidget(
                error: state.error,
                onPressed: () {
                  dispatch(OnlineTreasureBoxActionCreator.onFetchAction());
                },
              );
            }
          case ViewState.empty:
            {
              return ViewStateEmptyWidget(
                message: '空空如也',
                onPressed: () {},
              );
            }
          default:
            {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        dispatch(OnlineTreasureBoxActionCreator.onFetchAction());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25, bottom: 14),
                        child: Image.asset(
                          ImageHelper.wrapAssets("icon_online_box_title.png"),
                          height: 35,
                        ),
                      ),
                    ),
                    Text(
                      "${S.of(context).treasure_box_title01}",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 11),
                        padding: EdgeInsets.only(left: 30, right: 30),
                        height: 28,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(ImageHelper.wrapAssets("bg_online_box_award.png")), fit: BoxFit.fill)),
                        child: Marquee(
                          text: "${logString.toString()}",
                          blankSpace: 30,
                          style: TextStyle(
                            color: LmColors.theme_color,
                            fontSize: 14,
                          ),
                        )),
                    TreasureListView(treasureList, (code) {
                      debugPrint('点击事件$code');
                      dispatch(OnlineTreasureBoxActionCreator.onReceive(code));
                    }),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          ImageHelper.wrapAssets("icon_online_dot_left.png"),
                          width: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 3, right: 3),
                          child: Text(
                            '部分奖励展示',
                            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Image.asset(
                          ImageHelper.wrapAssets("icon_online_dot_right.png"),
                          width: 10,
                        ),
                      ],
                    ),
                    Container(
                      height: 70,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 15),
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: info.showAwardList.length,
                        separatorBuilder: (context, index) {
                          return Container(
                            width: 20,
                          );
                        },
                        itemBuilder: (context, index) {
                          Color color = Colors.white;

                          var item = info.showAwardList[index];
                          String text = item.awardName;
                          return Column(
                            children: <Widget>[
                              Container(
                                child: WrapperImage(url: "${item.awardPic}", height: 50, width: 50, fit: BoxFit.cover),
                                decoration: BoxDecoration(color: Color(0x1AFFFFFF), borderRadius: BorderRadius.circular(6.7)),
                                margin: EdgeInsets.only(bottom: 1),
                              ),
                              Text(
                                "$text",
                                style: TextStyle(fontSize: 12, color: color),
                              )
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            }
        }
      }),
    ),
  );
}

class TreasureListView extends StatefulWidget {
  final List<TreasureListListBean> treasureList;
  final Function(String) onItemClick;

  TreasureListView(this.treasureList, this.onItemClick) {
    debugPrint('TreasureListView 构造');
  }

  @override
  _TreasureListViewState createState() => _TreasureListViewState();
}

class _TreasureListViewState extends State<TreasureListView> with SingleTickerProviderStateMixin {
  List<TreasureListListBean> treasureList;
  Function(String) onItemClick;
  Timer _timer;
  Map<int, TreasureListListBean> _cdMap = Map<int, TreasureListListBean>();
  AnimationController _animationController;

  @override
  void initState() {
    debugPrint('initState=$_timer');

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    ) /*..addListener(() => debugPrint('执行动画监听'))*/;
    setAniAndTickData();
    super.initState();
  }

  void setAniAndTickData() {
    this.treasureList = widget.treasureList;
    this.onItemClick = widget.onItemClick;

    bool showAni = false;
    if (_timer == null) {
      _cdMap.clear();
//    _timer?.cancel();
      treasureList.forEach((item) {
        if ((item.ttl ?? 0) > 0) {
          _cdMap[treasureList.indexOf(item)] = item;
        }
        if (item.status == 'NotReceive') {
          showAni = true;
        }
      });
      if (_cdMap.isNotEmpty) {
        debugPrint('创建定时器-----------');
        _timer = Timer.periodic(Duration(seconds: 1), (timer) {
          debugPrint('_cdMap=$_cdMap');
          if (_cdMap.isEmpty) {
            _timer?.cancel();
          } else {
            setState(() {
              _cdMap.removeWhere((k, v) {
                var newValue = v.ttl - 1;
                var over = newValue <= 0 && v.ttl != 0;
                if (over) {
                  v.ttl = 0;
                  v.status = "NotReceive";
                } else {
                  v.ttl = newValue;
                }

                return over;
              });
            });
          }
        });
      }
    }
    //
    if (showAni) {
      debugPrint('开始播放动画 ${_animationController}');
      _animationController?.reset();
      _animationController?.repeat();
    } else {
      _animationController?.stop();
    }
  }

  @override
  void didUpdateWidget(TreasureListView oldWidget) {
    debugPrint('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
    setAniAndTickData();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    _animationController?.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    debugPrint('didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    debugPrint('reassemble');
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build开始=${_timer?.hashCode}');
    return Container(
      margin: EdgeInsets.only(top: 10, left: 50, right: 50, bottom: 15),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 2,
            crossAxisSpacing: 20,
            crossAxisCount: 3, //
            childAspectRatio: 0.79 //
            ),
        itemCount: treasureList.length,
        itemBuilder: (context, index) {
          Color color = Colors.white;
          String text;
          bool showBg = false;
          Color textBg = Colors.transparent;

          var item = treasureList[index];

          switch (item.status) {
            case "NotFinish":
              if ((item.ttl ?? 0) > 0) {
                color = Color(0xFFDEDEDE);
                textBg = Color(0x26FFFFFF);
                text = "${TimeUtils.countDownTimeFormat1(item.ttl)}";
              } else {
                text = "等待中";
              }
              break;
            case "NotReceive":
              text = "可领取";
              showBg = true;
              textBg = Color(0xFFFF3088);
//              showAni = true;
              break;
            case "Received":
              text = "${item.awardName}";
              break;
          }
//          if (showAni) {
//            debugPrint('开始播放动画 ${_animationController}');
//            _animationController?.reset();
//            _animationController?.forward();
//          } else {
//            _animationController?.stop();
//          }
          return GestureDetector(
            onTap: () {
              String code = item.treasureCode;
              String statue = item.status;
              if (code != null && onItemClick != null) {
                if (statue == "NotReceive") onItemClick(code);
              }
            },
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                    child: Offstage(
                      offstage: !showBg,
                      child: RotationTransition(
                        turns: CurvedAnimation(parent: _animationController, curve: Curves.linear),
                        child: Image.asset(
                          ImageHelper.wrapAssets("bg_task_animation.png"),
                          height: 70,
                          width: 70,
                        ),
                      ),
                    ),
                    top: 0),
                Positioned(
                  top: 9,
                  child: WrapperImage(url: "${item.awardPic}", height: 60, width: 55, fit: BoxFit.cover),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                      alignment: Alignment.center,
                      height: 20,
                      child: Text(
                        "$text",
                        style: TextStyle(fontSize: 12, color: color),
                      ),
                      decoration: BoxDecoration(
                        color: textBg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.only(left: 7, right: 7)),
                )
              ],
            ),
          );
        },
        shrinkWrap: true,
      ),
    );
  }
}
