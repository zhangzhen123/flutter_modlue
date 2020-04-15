import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmlive/beans/bean/user_info.dart';
import 'package:lmlive/config/resource_mananger.dart';
import 'package:lmlive/generated/l10n.dart';
import 'package:lmlive/provider/view_state.dart';
import 'package:lmlive/res/color.dart';
import 'package:lmlive/ui/widget/image.dart';
import 'package:lmlive/utils/string_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(UserCenterState state, Dispatch dispatch, ViewService viewService) {
  ViewState viewState = state.viewState;
  var userInfo = state.userInfo;

  return Scaffold(
      body: Container(
    padding: EdgeInsets.only(top: ScreenUtil.statusBarHeight),
    child: SmartRefresher(
      controller: state.refreshController,
      header: WaterDropHeader(),
      onRefresh: () async {
        dispatch(UserCenterActionCreator.onFetchAction());
      },
      enablePullUp: false,
      child: Builder(
        builder: (context) {
          if (viewState == ViewState.busy) {
            return Center(child: Text("正在忙"));
          } else if (viewState == ViewState.error) {
            return Center(child: Text('出错了${state.error}'));
          }
          return SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              UserHeaderView(userInfo),
              _stoneAndOther(),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10, top: 13, bottom: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          ImageHelper.wrapAssets("lm_icon_user_center_wallet.png"),
                          height: 24,
                          width: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("${S.of(context).myWallet}"),
                        )
                      ],
                    ),
                    Row(children: <Widget>[
                      Text(
                        '${userInfo.beans}萌豆',
                        style: TextStyle(color: LmColors.black_999, fontSize: 12),
                      ),
                      Image.asset(
                        ImageHelper.wrapAssets("forward.png"),
                        width: 20,
                        height: 20,
                      )
                    ])
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10, top: 13, bottom: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          ImageHelper.wrapAssets("lm_core_icon_user_center_cards.png"),
                          height: 24,
                          width: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("${S.of(context).user_cards}"),
                        )
                      ],
                    ),
                    Image.asset(
                      ImageHelper.wrapAssets("forward.png"),
                      width: 20,
                      height: 20,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10, top: 13, bottom: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          ImageHelper.wrapAssets("lm_icon_user_center_level.png"),
                          height: 24,
                          width: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("${S.of(context).user_level}"),
                        )
                      ],
                    ),
                    Row(children: <Widget>[
                      Text(
                        '差${userInfo.sjNeedExp}升级',
                        style: TextStyle(color: LmColors.black_999, fontSize: 12),
                      ),
                      Image.asset(
                        ImageHelper.wrapAssets("forward.png"),
                        width: 20,
                        height: 20,
                      )
                    ])
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10, top: 13, bottom: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          ImageHelper.wrapAssets("lm_icon_user_center_royal.png"),
                          height: 24,
                          width: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("${S.of(context).user_royal}"),
                        )
                      ],
                    ),
                    Row(children: <Widget>[
                      Text(
                        '${getRoyalNotice(userInfo)}',
                        style: TextStyle(color: LmColors.black_999, fontSize: 12),
                      ),
                      Image.asset(
                        ImageHelper.wrapAssets("forward.png"),
                        width: 20,
                        height: 20,
                      )
                    ])
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10, top: 13, bottom: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          ImageHelper.wrapAssets("lm_core_icon_user_center_welfare.png"),
                          height: 24,
                          width: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("${S.of(context).user_welfare_center}"),
                        )
                      ],
                    ),
                    Image.asset(
                      ImageHelper.wrapAssets("forward.png"),
                      width: 20,
                      height: 20,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10, top: 33, bottom: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          ImageHelper.wrapAssets("lm_icon_user_center_affiche.png"),
                          height: 24,
                          width: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("${S.of(context).help_affiche}"),
                        )
                      ],
                    ),
                    Image.asset(
                      ImageHelper.wrapAssets("forward.png"),
                      width: 20,
                      height: 20,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10, top: 13, bottom: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          ImageHelper.wrapAssets("lm_icon_user_center_about_us.png"),
                          height: 24,
                          width: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("${S.of(context).user_about_us}"),
                        )
                      ],
                    ),
                    Image.asset(
                      ImageHelper.wrapAssets("forward.png"),
                      width: 20,
                      height: 20,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10, top: 13, bottom: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          ImageHelper.wrapAssets("lm_icon_user_center_setting.png"),
                          height: 24,
                          width: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("${S.of(context).setting}"),
                        )
                      ],
                    ),
                    Image.asset(
                      ImageHelper.wrapAssets("forward.png"),
                      width: 20,
                      height: 20,
                    )
                  ],
                ),
              ),
            ],
          ));
        },
      ),
    ),
  ));
}

String getRoyalNotice(UserInfo userInfo) {
  String royalNotice;
  if (userInfo.royalStatus == ("None")) {
    //非贵族
    royalNotice = "充值${userInfo.royalDiffValue}元立即成为尚书";
  } else {
//            if (user.royalLevel == 8) {
//                if (user.userLevel < 35) {
//                    tv_royal_notice.text = "用户等级35级可飞升上神"
//                }else{
//                    tv_royal_notice.text = "充值${user.royalDiffValue}立即成为上神"
//                }
//            } else {
    switch (userInfo.royalStatus) {
      case "Ing":
        {
          //未保级
          royalNotice = "充值${userInfo.royalDiffValue}元即可成功保级";
          break;
        }
      case "Done":
        {
          //已保级

          if (boole(userInfo.isTopRoyalLevel)) {
            royalNotice = "本月已保级";
          } else {
            if (userInfo.royalLevel == 8) {
              if (userInfo.userLevel < 35) {
                royalNotice = "用户等级35级可飞升上神";
              } else {
                royalNotice = "充值${userInfo.royalDiffValue}立即成为上神";
              }
            } else {
              royalNotice = "已保级，差${userInfo.nextRoyalName}${userInfo.royalDiffValue}元";
            }
          }
          break;
        }
    }
//            }
  }
  return royalNotice;
}

class UserHeaderView extends StatelessWidget {
  final UserInfo userInfo;

  UserHeaderView(this.userInfo);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 44),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(70.w)),
                  child: WrapperImage(url: userInfo.headPic, height: 140.w, width: 140.w, fit: BoxFit.cover)),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${userInfo.nickname}",
                      style: TextStyle(color: LmColors.black_333, fontSize: 36.sp, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6, bottom: 6),
                      child: Text(
                        "羚萌ID:${userInfo.userId}",
                        style: TextStyle(color: LmColors.black_333, fontSize: 24.sp),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Image.asset(ImageHelper.wrapAssets(""), width: 68.w, height: 30.w),
                        Offstage(
                          offstage: userInfo.headPic != null && userInfo.headPic.isNotEmpty,
                          child: WrapperImage(url: userInfo.royalPic, height: 30.w, width: 68.w, fit: BoxFit.cover),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset(
              ImageHelper.wrapAssets("forward.png"),
              width: 40.w,
              height: 40.w,
            ),
          )
        ],
      ),
    );
    ;
  }
}

Container _stoneAndOther() {
  return Container(
    margin: EdgeInsets.only(left: 10, right: 10, top: 40, bottom: 25),
    padding: EdgeInsets.only(left: 38, right: 38, bottom: 15),
    decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0.0, 8.0), blurRadius: 7.0)],
//                    border: Border(
//                      top: BorderSide(color: Colors.red),
//                      bottom: BorderSide(color: Colors.red),
//                    )
        borderRadius: BorderRadius.circular(7)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Column(
            children: <Widget>[
              Image.asset(
                ImageHelper.wrapAssets("lm_icon_user_center_store.png"),
                width: 72.w,
                height: 72.w,
              ),
              Text(
                "商城",
                style: TextStyle(fontSize: 28.sp, color: LmColors.black_333),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Column(
            children: <Widget>[
              Image.asset(
                ImageHelper.wrapAssets("lm_icon_user_center_vehicle.png"),
                width: 72.w,
                height: 72.w,
              ),
              Text(
                "座驾",
                style: TextStyle(fontSize: 28.sp, color: LmColors.black_333),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Column(
            children: <Widget>[
              Image.asset(
                ImageHelper.wrapAssets("lm_icon_user_center_number.png"),
                width: 72.w,
                height: 72.w,
              ),
              Text(
                "靓号",
                style: TextStyle(fontSize: 28.sp, color: LmColors.black_333),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Column(
            children: <Widget>[
              Image.asset(
                ImageHelper.wrapAssets("lm_icon_user_center_badge.png"),
                width: 72.w,
                height: 72.w,
              ),
              Text(
                "勋章",
                style: TextStyle(fontSize: 28.sp, color: LmColors.black_333),
              )
            ],
          ),
        )
      ],
    ),
  );
}
