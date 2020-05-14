import 'package:flutter/material.dart' hide SliverAnimatedListState, SliverAnimatedList;
import 'package:flutter/material.dart';
import 'package:lmlive/Constant.dart';
import 'package:lmlive/beans/bean/follow.dart';
import 'package:lmlive/config/resource_mananger.dart';
import 'package:lmlive/generated/l10n.dart';
import 'package:lmlive/provider/provider_widget.dart';
import 'package:lmlive/provider/view_state_widget.dart';
import 'package:lmlive/res/color.dart';
import 'package:lmlive/ui/widget/image.dart';
import 'package:lmlive/view_model/follow_model.dart';
import 'package:provider/provider.dart';
import 'package:lmlive/extensions.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FollowListPage extends StatefulWidget {
  final String type;

  FollowListPage(this.type);

  @override
  _FollowListPageState createState() => _FollowListPageState();
}

class _FollowListPageState extends State<FollowListPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<FollowListModel>(
      model: FollowListModel(widget.type),
      onModelReady: (model) async {
        await model.initData();
      },
      builder: (context, FollowListModel model, child) {
        //todo 获取全局的推送开关状态
        var globalPush = false;
        if (model.isBusy) {
          return ViewStateBusyWidget();
        } else if (model.isEmpty) {
          return ViewStateEmptyWidget(onPressed: model.initData);
        } else if (model.isError) {
          if (model.viewStateError.isUnauthorized) {
            return ViewStateUnAuthWidget(onPressed: () async {
              //todo
//                var success =
//                    await Navigator.of(context).pushNamed(RouteName.login);
//                // 登录成功,获取数据,刷新页面
//                if (success ?? false) {
//                  model.initData();
//                }
            });
          } else if (model.list.isEmpty) {
            // 只有在页面上没有数据的时候才显示错误widget
            return ViewStateErrorWidget(error: model.viewStateError, onPressed: model.initData);
          }
        }
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Offstage(
                offstage: widget.type != FollowPageType.FOLLOW,
                child: globalPush
                    ? Container(
                        alignment: Alignment.centerLeft,
                        height: 42,
                        padding: EdgeInsets.only(left: 15),
                        color: Color(0xFFFAFBFC),
                        child: Text(
                          S.of(context).open_push_title,
                          style: TextStyle(fontSize: 12, color: LmColors.black_666),
                        ),
                      )
                    : Container(
                        color: Color(0xffFFF6D1),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          leading: null,
                          title: Text(S.of(context).open_push_close_notice,
                              style: TextStyle(fontSize: 12, color: LmColors.black_333)),
                          subtitle:
                              Text(S.of(context).open_push_guide, style: TextStyle(fontSize: 12, color: LmColors.black_666)),
                          trailing: Container(
                            height: 24,
                            width: 60,
                            child: FlatButton(
                              padding: EdgeInsets.all(1),
                              child: Text('去设置', style: TextStyle(fontSize: 12, color: LmColors.black_333)),
                              color: LmColors.theme_color,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
                              onPressed: () {
                                //todo 打开系统推送开关设置
                              },
                            ),
                          ),
                        ),
                      )),
            Expanded(
              child: SmartRefresher(
                  controller: model.refreshController,
                  header: WaterDropHeader(),
                  onRefresh: () async {
                    await model.refresh();
                  },
                  onLoading: () async {
                    await model.loadMore();
                  },
                  enablePullUp: true,
                  child: ListView.builder(
                      itemCount: model.list.length,
                      itemBuilder: (context, index) {
//                        debugPrint("当前的item:$index");
                        Follow item = model.list[index];
                        switch (widget.type) {
                          case FollowPageType.FOLLOW:
                            {
                              return InkWell(
                                onTap: () {
                                  debugPrint('点击了 ${item.programId}');
                                },
                                child: Container(
                                  height: 50,
                                  margin: EdgeInsets.all(15),
                                  child: Row(
                                    children: <Widget>[
                                      Stack(
                                        alignment: AlignmentDirectional.center,
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(25)),
                                            child: WrapperImage(
                                              url: item.anchorPic,
                                              width: 50,
                                              height: 50,
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            child: Offstage(
                                              offstage: !item.isLiving.boolean,
                                              child: Container(
                                                child: Row(
                                                  children: <Widget>[
                                                    Image.asset(
                                                      ImageHelper.wrapAssets("lm_common_gif_isliving.gif"),
                                                      height: 8,
                                                      width: 8,
                                                    ),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    Text(
                                                      '直播中',
                                                      style: TextStyle(
                                                          fontSize: 9, color: LmColors.black_333, fontWeight: FontWeight.bold),
                                                    )
                                                  ],
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                ),
                                                decoration: BoxDecoration(
                                                    color: LmColors.theme_color, borderRadius: BorderRadius.circular(16)),
                                                height: 14,
                                                width: 50,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Builder(builder: (context) {
                                                  var text = Text('${item.programName}',
                                                      style: TextStyle(color: LmColors.black_333, fontSize: 16),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis);
                                                  if (item.programName.length > 10) {
                                                    return Expanded(
                                                      child: text,
                                                    );
                                                  } else {
                                                    return text;
                                                  }
                                                }),
                                                SizedBox(
                                                  width: 9,
                                                ),
                                                Image.asset(
                                                  //todo 主播等级图标替换
                                                  ImageHelper.wrapAssets("anchor_lv1.png"),
                                                  height: 16,
                                                ),
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.start,
                                            ),
                                            Text(
                                              item.isLiving.boolean ? '观众:${item.onlineUserNum}' : '上次直播:${item.lastShowTime}',
                                              style: TextStyle(color: LmColors.black_999),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                        iconSize: 51,
                                        padding: EdgeInsets.all(1),
                                        onPressed: globalPush
                                            ? () {
                                                model.changePush(item.pushOpen.inverse, item.programId);
//                                        setState(() {
//                                          item.pushOpen = item.pushOpen.inverse;
//                                        });
                                              }
                                            : null,
                                        icon: Builder(builder: (context) {
                                          if (globalPush) {
                                            return item.pushOpen.boolean
                                                ? Image.asset(ImageHelper.wrapAssets("icon_notify_open.png"),
                                                    height: 31, width: 51, fit: BoxFit.contain)
                                                : Image.asset(ImageHelper.wrapAssets("icon_notify_close.png"),
                                                    height: 31, width: 51, fit: BoxFit.contain);
                                          } else {
                                            return item.pushOpen.boolean
                                                ? Image.asset(ImageHelper.wrapAssets("icon_notify_open_enable.png"),
                                                    height: 31, width: 51, fit: BoxFit.cover)
                                                : Image.asset(ImageHelper.wrapAssets("icon_notify_close_enable.png"),
                                                    height: 31, width: 51, fit: BoxFit.cover);
                                          }
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                        }
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            child: WrapperImage(
                              url: item.anchorPic,
                              width: 50,
                              height: 50,
                            ),
                          ),
                          title: Row(
                            children: <Widget>[
                              Builder(builder: (context) {
                                var text = Text('${item.programName}',
                                    style: TextStyle(color: LmColors.black_333, fontSize: 16),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis);
                                if (item.programName.length > 10) {
                                  return Expanded(
                                    child: text,
                                  );
                                } else {
                                  return text;
                                }
                              }),
                              SizedBox(
                                width: 9,
                              ),
                              Image.asset(
                                //todo 主播等级图标替换
                                ImageHelper.wrapAssets("anchor_lv1.png"),
                                height: 16,
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.start,
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Builder(builder: (context) {
                              switch (widget.type) {
                                case FollowPageType.GUARD:
                                  {
                                    return Text(
                                      '剩余:${item.surplusDay}天',
                                      style: TextStyle(color: LmColors.black_999),
                                    );
                                  }
                                default:
                                  return Text(
                                    item.isLiving.boolean ? '观众:${item.onlineUserNum}' : '上次直播:${item.lastShowTime}天',
                                    style: TextStyle(color: LmColors.black_999),
                                  );
                              }
                            }),
                          ),
                          trailing: Container(
                            decoration: BoxDecoration(color: LmColors.theme_color, borderRadius: BorderRadius.circular(12)),
                            height: 24,
                            width: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  ImageHelper.wrapAssets("lm_common_gif_isliving.gif"),
                                  height: 12,
                                  width: 12,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "直播中",
                                  style: TextStyle(fontSize: 10, color: LmColors.black_333),
                                )
                              ],
                            ),
                          ),
                          onTap: () {},
                        );
                      })),
            ),
          ],
        );
      },
    );
  }

//IndexedStack保存页面也可以实现保活复用
  @override
  bool get wantKeepAlive => true;
}
