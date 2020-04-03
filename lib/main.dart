import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lmlive/config/provider_manager.dart';
import 'package:lmlive/ui/dialog/dialog_helper.dart';
import 'package:lmlive/ui/dialog/more_action_dialog.dart';
import 'package:lmlive/ui/widget/app_update.dart';
import 'package:lmlive/utils/community.dart';
import 'package:lmlive/utils/screen_utils.dart';
import 'package:lmlive/utils/session_utils.dart';
import 'package:lmlive/view_model/locale_model.dart';
import 'package:lmlive/view_model/theme_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

import 'config/storage_manager.dart';
import 'generated/l10n.dart';
import 'package:lmlive/res/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  CommunityUtil.initMessageHandler();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This ui.widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MultiProvider(
        providers: providers,
        child: Consumer2<ThemeModel, LocaleModel>(
          builder: (context, themeModel, localeModel, child) {
            return RefreshConfiguration(
                hideFooterWhenNotFull: true,
                child: MaterialApp(
                  title: 'Flutter Demo',
                  debugShowCheckedModeBanner: false,
                  theme: themeModel.themeData(),
                  darkTheme: themeModel.themeData(platformDarkMode: true),
                  locale: localeModel.locale,
                  localizationsDelegates: const [
                    S.delegate,
//          RefreshLocalizations.delegate, //下拉刷新
                    GlobalCupertinoLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate
                  ],
                  supportedLocales: S.delegate.supportedLocales,
                  home: MyHomePage(title: 'Flutter Demo Home Page'),
                ));
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This ui.widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App ui.widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      checkAppUpdate(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout ui.widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                onPressed: () {
                  SessionUtils.instance
                      .setSessionId('284ae7fb800f41ec9aa5a3b71e423dce');
                },
                color: LmColors.theme_color,
                child: Text("登录")),
            FlatButton(
                onPressed: () {
//                  showListDialog(context);
                  showBottomDialog(context, (BuildContext context) {
//                    return MoreActionDialog2();
                    return MoreActionDialog1();
                  });
                },
                color: LmColors.theme_color,
                child: Text("测试更多菜单")),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
