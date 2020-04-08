import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lmlive/beans/bean/user_more_action.dart';
import 'package:lmlive/config/resource_mananger.dart';
import 'package:lmlive/manager/GlobalDataManager.dart';
import 'package:lmlive/provider/provider_widget.dart';
import 'package:lmlive/res/index.dart';
import 'package:lmlive/ui/widget/image.dart';
import 'package:lmlive/utils/community.dart';
import 'package:lmlive/utils/screen_utils.dart';
import 'package:lmlive/view_model/user_more_action_model.dart';
import 'package:oktoast/oktoast.dart';

import '../../Constant.dart';

///第一种构建更多操作的方式
class MoreActionDialog1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint('MoreActionDialog1 build');
    return buildShapeContainer1();
  }

  //创建带圆角的容器方法1
  Widget buildShapeContainer1() {
    return ProviderWidget<UserMoreActionModel>(
      model: UserMoreActionModel(GlobalDataManager.currentProgramId),
      onModelReady: (model) => model.initData(),
      builder: (context, model, child) {
        return Container(
          height: pt(238),
          alignment: Alignment.center,
          decoration: ShapeDecoration(
              color: LmColors.more_action_bg,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)))),
          child: Builder(
            builder: (build) {
              if (model.isBusy) {
                return Text(
                  '加载中。。。。',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                );
              } else if (model.isError) {
                return Text(
                  '出错了。。。',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                );
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: pt(30), bottom: pt(25)),
//          color: LmColors.gray_background,
                    height: pt(62),
                    child: buildGridView(
                        model?.data?.actItems, model?.data?.shareInfo),
//                      ),
//                      ),
                  ),
                  Divider(
                    color: Color(0x1affffff),
                    height: pt(1),
                    indent: pt(25),
                    endIndent: pt(25),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: pt(30), bottom: pt(25)),
//                      color: LmColors.warning_red,
                      height: pt(62),
                      child: buildGridView(
                          model?.data?.menuItems, model.data.shareInfo)),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

///第2种构建更多操作的方式
class MoreActionDialog2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildClipRRect();
  }

//创建带圆角的容器方法2
  ClipRRect buildClipRRect() {
    debugPrint('buildClipRRect');
    return ClipRRect(
//                      borderRadius: BorderRadius.circular(15),
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      child: Container(
        color: LmColors.more_action_bg,
//                      height: double.infinity,
        child: buildColumn(),
      ),
    );
  }
}

Column buildColumn() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(top: pt(30), bottom: pt(25)),
//          color: LmColors.gray_background,
        height: pt(62),
        child: buildGridView(null, null),
//                      ),
//                      ),
      ),
      Divider(
        color: Color(0x1affffff),
        height: pt(1),
        indent: pt(25),
        endIndent: pt(25),
      ),
      Container(
          margin: EdgeInsets.only(top: pt(30), bottom: pt(25)),
          color: LmColors.warning_red,
          height: pt(62),
          child: buildGridView(null, null)),
    ],
  );
}

GridView buildGridView(
    List<MenuItemsListBean> menuItems, ShareInfoBean shareInfo) {
  return GridView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: pt(20)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          crossAxisCount: 1, //
          childAspectRatio: 1.24 //
          ),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        MenuItemsListBean item = menuItems[index];
        String imageUrl;
        ImageType imageType;
        switch (item.itemCode) {
          case ShareConstants.SHARE_WX:
            imageType = ImageType.assets;
            imageUrl = 'action_share_wx.png';
            break;
          case ShareConstants.SHARE_QQ:
            imageType = ImageType.assets;
            imageUrl = 'action_share_qq.png';
            break;
          case ShareConstants.SHARE_QQ_ZONE:
            imageType = ImageType.assets;
            imageUrl = 'action_share_qqzone.png';
            break;
          case ShareConstants.SHARE_WX_FRIENDS:
            imageType = ImageType.assets;
            imageUrl = 'action_share_wx_pyq.png';
            break;
          case ShareConstants.SHARE_COPY:
            imageType = ImageType.assets;
            imageUrl = 'action_share_copy_link.png';
            break;
          default:
            imageType = ImageType.normal;
            imageUrl = ImageHelper.wrapUrl(item.itemPic);
        }
        return GestureDetector(
          onTap: () {
            CommunityUtil.funToPager(CommunityUtil.METHOD_LOCAL, {
              "itemCode": jsonEncode(item),
              "shareInfo": jsonEncode(shareInfo)
            });
            showToast('点击了第${index + 1}个选项--${item.itemName}');
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                child: imageType == ImageType.normal
                    ? WrapperImage(
                        imageType: imageType,
                        url: imageUrl,
                        height: pt(40),
                        width: pt(40),
                        fit: BoxFit.cover)
                    : Image.asset(
                        ImageHelper.wrapAssets(imageUrl),
                        width: pt(40),
                        height: pt(40),
                      ),
              ),
              Positioned(
                top: 1,
                left: 1,
                child: Offstage(
                  offstage: item?.tag == null || item.tag.isEmpty,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: pt(3), top: 1, right: pt(3), bottom: 1),
                    decoration: ShapeDecoration(
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                    child: Text(
                      '${item.tag}',
                      style: TextStyle(fontSize: 6, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 1,
                child: Container(
                  width: pt(50),
                  alignment: Alignment.center,
                  child: Text(
                    "${item.itemName}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12,
                        color: LmColors.black_999,
                        decoration: TextDecoration.none),
                  ),
                ),
              )
            ],
          ),
        );
      });
}
