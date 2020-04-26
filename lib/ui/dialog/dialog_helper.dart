import 'package:flutter/material.dart';

// 弹出底部菜单列表模态对话框  isScrollControlled为true时 弹窗的高度会解除限制 不然只能最大9/16
Future<dynamic> showBottomDialog(BuildContext context, WidgetBuilder builder, {bool isScrollControlled = true}) {
  return showModalBottomSheet<dynamic>(
      backgroundColor: Colors.transparent, context: context, builder: builder, isScrollControlled: isScrollControlled);
}
