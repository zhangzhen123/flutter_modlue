import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';

class OptionUtils {
  static void addDefaultOptions(IjkMediaController controller) {
    controller.addIjkPlayerOptions(
      [TargetPlatform.iOS, TargetPlatform.android],
      createIJKOptions(),
    );
  }

  static Set<IjkOption> createIJKOptions() {
    return <IjkOption>[
      IjkOption(IjkOptionCategory.player, "mediacodec", 1),
      IjkOption(IjkOptionCategory.player, "mediacodec-hevc", 1),
      IjkOption(IjkOptionCategory.player, "videotoolbox", 1),
      IjkOption(IjkOptionCategory.player, "opensles", 0),
      IjkOption(IjkOptionCategory.player, "overlay-format", 0x32335652),
//      IjkOption(IjkOptionCategory.player, "start-on-prepared", 0),
      IjkOption(IjkOptionCategory.format, "http-detect-range-support", 0),

//    var option1 = IjkOption(IjkOptionCategory.format, "fflags", "fastseek");
      //最大缓冲大小,默认值15*1024*1024即15M
      IjkOption(IjkOptionCategory.player, "max-buffer-size", 1024 * 1000),
      //最大缓存时长
      IjkOption(IjkOptionCategory.player, "max_cached_duration", 3),
      // 设置播放前的探测时间 1,达到首屏秒开效果
      IjkOption(IjkOptionCategory.format, "analyzeduration", 1),
      //播放前的探测Size，默认是1M, 改小一点会出画面更快
      IjkOption(IjkOptionCategory.format, "probesize", 1024 * 10),
      //跳过循环滤波; 0 开启，画面质量高，解码开销大; 48 关闭， 画面质量差，解码开销小
      IjkOption(IjkOptionCategory.codec, "skip_loop_filter", 48),
      //设置最长分析时长
      IjkOption(IjkOptionCategory.format, "analyzemaxduration", 100),
      //通过立即清理数据包来减少等待时长
      IjkOption(IjkOptionCategory.format, "flush_packets", 1),
      //暂停输出直到停止后读取足够的数据包，buffering方法不再执行
      IjkOption(IjkOptionCategory.format, "packet-buffering", 0),
      //网络不好的情况下进行丢包
      IjkOption(IjkOptionCategory.player, "framedrop", 1),
      //不查询stream_info，直接使用
//      IjkOption(IjkOptionCategory.player, "find_stream_info", 0),
      //等待开始之后才绘制
      IjkOption(IjkOptionCategory.player, "render-wait-start", 1),
      //设置停止预读取的最小帧数，范围2～50000，默认值50000
      IjkOption(IjkOptionCategory.player, "min-frames", 100),

      //设置第一次唤醒read_thread线程的时间(毫秒)，范围100～5000，默认值100
      IjkOption(IjkOptionCategory.player, "first-high-water-mark-ms", 100),
      //设置第一次唤醒read_thread线程的时间(毫秒)，范围100～5000，默认值100
      IjkOption(IjkOptionCategory.player, "next-high-water-mark-ms", 1000),
      //设置下一次唤醒read_thread线程的时间(毫秒)，范围100～5000，默认值1000
      IjkOption(IjkOptionCategory.player, "last-high-water-mark-ms", 5000),
    ].toSet();
  }
}
