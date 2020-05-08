import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:lmlive/config/resource_mananger.dart';
import 'package:lmlive/ui/pager/program/view.dart';
import 'package:lmlive/ui/widget/image.dart';
import 'package:lmlive/utils/string_utils.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(ProgramCellState state, Dispatch dispatch, ViewService viewService) {
  var data = state.programBean;
  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    child: Stack(
      children: [
        Positioned(
          child: WrapperImage(
            url: data.coverPic,
            width: (ScreenUtil.screenWidthDp - HOME_SPACE * 3) / 2,
            height: (ScreenUtil.screenWidthDp - HOME_SPACE * 3) / 2,
          ),
        ),
        //底部阴影
        Positioned(
          bottom: 0,
          child: Image.asset(
            ImageHelper.wrapAssets('shadow_home_item.png'),
            width: (ScreenUtil.screenWidthDp - HOME_SPACE * 3) / 2,
            height: 34,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          left: 6,
          bottom: 6,
          child: Column(
            verticalDirection: VerticalDirection.up,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${data.programName}',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Offstage(
                offstage: boole(data.isPcLive),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 3),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0XFF00CFC7),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text(
                    '手机直播',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              )
            ],
          ),
        ),

        Positioned(
          top: 6,
          right: 5,
          child: Offstage(
            offstage: !boole(data.isLiving),
            child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                child: Text(
                  '直播中',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                  textAlign: TextAlign.center,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0X33E9E9E9)),
                  color: Color(0X33000000),
                  borderRadius: BorderRadius.circular(7),
                )),
          ),
        ),
      ],
    ),
  );
}
