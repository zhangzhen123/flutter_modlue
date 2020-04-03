import 'package:flutter/material.dart';

Future<void> showListDialog(BuildContext context) async {
  int index = await showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      var child = Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('我是弹窗头部'),
          ),
          ListTile(title: Text("请选择")),
          Expanded(
              child: ListView.builder(
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text("$index"),
                onTap: () => Navigator.of(context).pop(index),
              );
            },
          )),
        ],
      );
      //使用AlertDialog会报错
      //return AlertDialog(content: child);
      return Dialog(child: child);
    },
  );
  if (index != null) {
    print("点击了：$index");
  }
}

// 弹出底部菜单列表模态对话框
Future<int> showBottomDialog(BuildContext context, WidgetBuilder builder) {
  return showModalBottomSheet<int>(
    backgroundColor: Colors.transparent,
    context: context,
    builder: builder,
  );
}
