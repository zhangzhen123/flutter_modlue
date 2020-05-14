import 'package:flutter/cupertino.dart';
import 'package:lmlive/Constant.dart';
import 'package:lmlive/beans/base/RootListData.dart';
import 'package:lmlive/beans/bean/follow.dart';
import 'package:lmlive/net/services/program_repository.dart';
import 'package:lmlive/net/services/user_repository.dart';
import 'package:lmlive/provider/view_state.dart';
import 'package:lmlive/provider/view_state_refresh_list_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:lmlive/extensions.dart';

/// 我的关注列表
class FollowListModel extends ViewStateRefreshListModel<Follow> {
  String type;

  FollowListModel(this.type);

  @override
  void onError(ViewStateError viewStateError) {}

  @override
  Future<RootListData<Follow>> loadData({int offset}) async {
    switch (type) {
      case FollowPageType.FOLLOW:
        {
          return await ProgramRepository.fetchFollowList(offset);
        }
      case FollowPageType.GUARD:
        {
          return await UserRepository.fetchGuardList(offset);
        }
      case FollowPageType.MANAGER:
        {
          return await UserRepository.fetchManagerList(offset);
        }
      case FollowPageType.SEE:
        {
          return await ProgramRepository.fetchWatchedRecord(offset);
        }
      default:
        {
          return await ProgramRepository.fetchFollowList(offset);
        }
    }
  }

  changePush(String pushOpen, int programId) async {
    ProgramRepository.changeFollowPush(pushOpen, programId).then((info) {
      var item = list.firstWhere((item) => item.programId == programId, orElse: () => null);
      item?.pushOpen = item.pushOpen.inverse;
      debugPrint('item改变了=${item.programId} ${item.pushOpen}');
      notifyListeners();
//      list.where((item) => item.programId == programId).forEach((item) {
//        item.pushOpen = item.pushOpen.inverse;
//      });
    }, onError: (e, s) {
      showToast(s);
    });
  }
}
