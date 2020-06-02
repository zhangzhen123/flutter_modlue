import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:lmlive/beans/bean/program.dart';
import 'package:lmlive/utils/ijk_options_utils.dart';
import 'action.dart';
import 'state.dart';

Effect<ProgramVideoState> buildEffect() {
  return combineEffects(<Object, Effect<ProgramVideoState>>{
//    ProgramVideoAction.action: _onAction,
    Lifecycle.initState: _init,
    Lifecycle.didUpdateWidget: _didUpdate,
    Lifecycle.dispose: _onDispose
  });
}

Future<void> _init(Action action, Context<ProgramVideoState> ctx) async {
  debugPrint('ProgramVideoState _init =${ctx.state.video}  sta=${ctx.state.hashCode}');

  //  ctx.state.ijkController = IjkMediaController();
  var url = getPlayUrl(ctx.state.video?.playInfo);
  //  url = 'rtmp://aliyun-rtmp.51lm.tv/lingmeng/27536';
  debugPrint('_init playInfo=$url ijk=${ctx.state.ijkController.hashCode}');
  var ijkController = ctx.state.ijkController;
  //配置播放器的默认优化参数
  OptionUtils.addDefaultOptions(ijkController);
  //此处去除音频
  ijkController.addIjkPlayerOptions(
    [TargetPlatform.iOS, TargetPlatform.android],
    [IjkOption(IjkOptionCategory.player, "an", 1)],
  );
  await ctx.state.ijkController.pauseOtherController();
  await ctx.state.ijkController.setNetworkDataSource(url, autoPlay: true);
  debugPrint('_init 设置源成功');
//  await ctx.state.ijkController.play();
//  debugPrint('开始播放成功');
}

Future<void> _didUpdate(Action action, Context<ProgramVideoState> ctx) async {
  debugPrint('ProgramVideoState _didUpdate =${ctx.state.video}  sta=${ctx.state.hashCode}');

//  ctx.state.ijkController = IjkMediaController();
  var url = getPlayUrl(ctx.state.video?.playInfo);
//  url = 'rtmp://aliyun-rtmp.51lm.tv/lingmeng/27536';
  debugPrint('ProgramVideoState _didUpdate playInfo=$url ijk=${ctx.state.ijkController.hashCode}');
  await ctx.state.ijkController.pauseOtherController();
  debugPrint('ProgramVideoState _didUpdate pauseOtherController');
  await ctx.state.ijkController.setNetworkDataSource(url, autoPlay: true);
  debugPrint('ProgramVideoState _didUpdate 设置源成功');
//  await ctx.state.ijkController.play();
//  debugPrint('开始播放成功');
}

Future _onDispose(Action action, Context<ProgramVideoState> ctx) async {
  debugPrint('ProgramVideoState _onDispose sta=${ctx.state.ijkController.hashCode}');
  //这里不能dispose 因为这里控件是adapter的一个item 滑动时会正常dispose和重新创建
//  ctx.state.ijkController?.dispose();
  ctx.state.ijkController?.pause();
}

/// 获取播放地址
String getPlayUrl(PlayInfoBean info) {
  if (info == null) {
    return null;
  }
  var type = info.type;
  if (type == PlayInfoBean.Url) {
    //URL格式
    return info.rtmp;
  } else {
    var string = "rtmp://${info.domain}-rtmp.51lm.tv${info.streamKey}";
    return string;
  }
}
