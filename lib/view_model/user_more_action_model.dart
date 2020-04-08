import 'package:flutter/cupertino.dart';
import 'package:lmlive/Constant.dart';
import 'package:lmlive/beans/bean/user_more_action.dart';
import 'package:lmlive/net/services/live_repository.dart';
import 'package:lmlive/provider/view_state_simple_model.dart';

/// 获取更多操作
class UserMoreActionModel extends ViewStateSimpleModel<UserMoreAction> {
  int programId;
  UserMoreActionModel(this.programId);

  var shareList = [
    MenuItemsListBean(
        itemCode: ShareConstants.SHARE_WX,
        itemName: ShareConstants.SHARE_WX_TEXT),
    MenuItemsListBean(
        itemCode: ShareConstants.SHARE_WX_FRIENDS,
        itemName: ShareConstants.SHARE_WX_FRIENDS_TEXT),
    MenuItemsListBean(
        itemCode: ShareConstants.SHARE_QQ,
        itemName: ShareConstants.SHARE_QQ_TEXT),
    MenuItemsListBean(
        itemCode: ShareConstants.SHARE_QQ_ZONE,
        itemName: ShareConstants.SHARE_QQ_ZONE_TEXT),
    MenuItemsListBean(
        itemCode: ShareConstants.SHARE_COPY,
        itemName: ShareConstants.SHARE_COPY_TEXT)
  ];

  @override
  Future<UserMoreAction> loadData() async {
    debugPrint("getActionList start");
    var actionList = await LiveRepository.getActionList(programId);
    if (actionList.actItems == null) {
      actionList.actItems = [];
    }
    actionList.actItems.addAll(shareList);
    return actionList;
  }

  @override
  onCompleted(UserMoreAction data) {}
}
