
import 'package:flutter/material.dart';
import 'package:redstonex/app-configs/init/redstonex_initializer.dart';

class RsxDefaultApp {
  static void run(Widget myApp, {Function()? preBuiltinInit, Function()? postBuiltinInit}) async {
    WidgetsFlutterBinding.ensureInitialized();
    /// 应用程序初始化
    await RsxInitializer.init(preBuiltinInit: preBuiltinInit, postBuiltinInit: postBuiltinInit);

    runApp(myApp);
  }
}