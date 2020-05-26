import 'package:flutter/cupertino.dart';
import 'package:lmlive/Constant.dart';
import 'package:lmlive/beans/base/RootListData.dart';
import 'package:lmlive/beans/bean/follow.dart';
import 'package:lmlive/net/services/program_repository.dart';
import 'package:lmlive/net/services/user_repository.dart';
import 'package:lmlive/provider/view_state.dart';
import 'package:lmlive/provider/view_state_refresh_list_model.dart';
import 'package:lmlive/provider/view_state_simple_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:lmlive/extensions.dart';

/// 主页
class MainModel extends ViewStateSimpleModel<Follow> {
  MainModel() {
    debugPrint('MainModel');
  }

  @override
  void onError(ViewStateError viewStateError) {}

  @override
  Future<Follow> loadData() {
    // TODO: implement loadData
    return null;
  }
}
