import 'dart:ffi';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmlive/ui/widget/image.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(ProgramVideoState state, Dispatch dispatch, ViewService viewService) {
//  var data = state.videoList;
  debugPrint(
      'buildView xxxxx ProgramVideoState=${state.ijkController?.hashCode} ijkController=${state.ijkController} state=${state.video} ');
//  state.ijkController.ijkStatusStream.listen((event) {
//    debugPrint('ProgramVideoState event=$event');
//    if (event == IjkStatus.playing) {
//      state.ijkController.refreshVideoInfo();
//    }
//  });

  ///后续自定义状态控件用
  Widget buildStatusWidget(
    BuildContext context,
    IjkMediaController controller,
    IjkStatus status,
  ) {
    debugPrint("ProgramVideoState 我是状态控件 statue=$status");
    if (status != IjkStatus.playing) {
      return WrapperImage(url: state.video.coverPic, height: double.infinity, width: double.infinity, fit: BoxFit.cover);
    } else {
      state.ijkController.refreshVideoInfo();
    }
    return Container();
  }

  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    child: IjkPlayer(
      mediaController: state.ijkController,
      controllerWidgetBuilder: _buildControllerWidget,
      textureBuilder: _textureBuilder,
      statusWidgetBuilder: buildStatusWidget,
    ),
  );
}

Widget _buildControllerWidget(IjkMediaController controller) {
  return Builder(
    builder: (BuildContext context) {
      return Container();
    },
  );
}

///后续自定义播放纹理控件用
Widget _textureBuilder(BuildContext context, IjkMediaController controller, VideoInfo videoInfo) {
  debugPrint('VideoInfo=$videoInfo');
  return DefaultIJKPlayerWrapper(controller: controller, info: videoInfo);
}

/// Default IJKPlayer Wrapper
///
/// This widget solves the aspect ratio problem in video direction.
class DefaultIJKPlayerWrapper extends StatelessWidget {
  final IjkMediaController controller;
  final VideoInfo info;

  const DefaultIJKPlayerWrapper({
    Key key,
    this.controller,
    this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var id = controller.textureId;
    double ratio = info?.ratio ?? 1280 / 720;
    return Container(
      width: ScreenUtil.screenWidth,
      height: double.infinity,
      color: Colors.deepOrange,
//      decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(6.7)),
      child: FittedBox(
        child: Container(
          width: ScreenUtil.screenWidth,
          height: ScreenUtil.screenWidth / ratio,
          color: Colors.blue,
          child: Texture(
            textureId: id,
          ),
        ),
        fit: BoxFit.cover,
      ),
    );
//    double ratio = info?.ratio ?? 1280 / 720;
//
//    var id = controller.textureId;
//
//    if (id == null) {
//      return AspectRatio(
//        aspectRatio: ratio,
//        child: Container(
//          color: Colors.black,
//        ),
//      );
//    }
//
//    Widget w = Container(
//      color: Colors.black,
//      child: Texture(
//        textureId: id,
//      ),
//    );
//
//    if (!controller.autoRotate) {
//      return w;
//    }
//
//    int degree = info?.degree ?? 0;
//
//    if (ratio == 0) {
//      ratio = 1280 / 720;
//    }
//
//    w = AspectRatio(
//      aspectRatio: ratio,
//      child: w,
//    );
//
//    if (degree != 0) {
//      w = RotatedBox(
//        quarterTurns: degree ~/ 90,
//        child: w,
//      );
//    }
//
//    return Container(
//      child: w,
//      alignment: Alignment.center,
//      color: Colors.black,
//    );
  }
}
