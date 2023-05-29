import 'package:flutter/material.dart';

import 'redstonex_initializer.dart';

/// 默认应用处理器
class rDefaultApp {
  static void run(Widget myApp, {Function()? preBuiltinInit, Function()? postBuiltinInit}) async {
    WidgetsFlutterBinding.ensureInitialized();

    /// 应用程序初始化
    await rInitializer.init(preBuiltinInit: preBuiltinInit, postBuiltinInit: postBuiltinInit);

    runApp(myApp);
  }
}
