import 'dart:core';

///一些列表请求的通用基类 由于dart不支持反射 这里无法使用泛型去实例化对象 具体的item类型还需要具体调用出去调用T.fromJson去转换
typedef ToBeanFun<T> = T Function(dynamic item);

class RootListData<T> {
  //本地字段
  bool isPull = false;
  List<T> list;
  String hasMore = "";
  String extDataJson;
  ToBeanFun<T> _itemToBeanFun;

  RootListData({this.list, this.hasMore: "", this.extDataJson});

  RootListData.fromJson(ToBeanFun<T> itemToBeanFun, Map<String, dynamic> json) {
    _itemToBeanFun = itemToBeanFun;
    if (_itemToBeanFun != null) {
      this.list = (json['list'] as List) != null ? (json['list'] as List).map(_itemToBeanFun).toList() : [];
    } else {
      this.list = (json['list'] as List) != null ? (json['list'] as List) /*.map(itemToBeanFun).toList()*/ : [];
    }

    this.extDataJson = json['extDataJson'];
    this.hasMore = json['hasMore'];
  }
}
