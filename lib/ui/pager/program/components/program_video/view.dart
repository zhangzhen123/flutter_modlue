import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(ProgramVideoState state, Dispatch dispatch, ViewService viewService) {
  var data = state.videoList;
  return Container(
      color: Colors.green,
      child: new Center(
        child: new CircleAvatar(
          backgroundColor: Colors.white,
          child: new Text('${data.length}  我是视频'),
        ),
      ));
}
