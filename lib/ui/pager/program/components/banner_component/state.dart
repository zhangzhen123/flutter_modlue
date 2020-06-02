import 'package:fish_redux/fish_redux.dart';
import 'package:lmlive/beans/bean/multiple_type.dart';
import 'package:lmlive/beans/bean/program.dart';
import 'package:lmlive/ui/pager/program/state.dart';

class ProgramBannerState extends MultipleType implements Cloneable<ProgramBannerState> {
  List<BannerListListBean> bannerList;

  ProgramBannerState({this.bannerList});

  @override
  ProgramBannerState clone() {
    return ProgramBannerState()..bannerList = bannerList;
  }

  @override
  String get type => ProgramState.TYPE_BANNER;
}

//ProgramBannerState initState(Map<String, dynamic> args) {
//  return ProgramBannerState();
//}
