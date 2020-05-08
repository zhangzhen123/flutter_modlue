import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(ProgramBannerState state, Dispatch dispatch, ViewService viewService) {
  var data = state.bannerList;
  return Container(
      color: Colors.green,
      child: new Center(
        child: new CircleAvatar(
          backgroundColor: Colors.white,
          child: new Text('我是banner'),
        ),
      ));
}
