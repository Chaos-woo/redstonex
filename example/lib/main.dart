import 'package:example/homepage/homepage/homepage_logic.dart';
import 'package:example/homepage/homepage/homepage_view.dart';
import 'package:example/providers/business_providers.dart';
import 'package:example/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:redstonex/redstonex.dart';

void main() async {
  /// Flutter组件绑定必须
  WidgetsFlutterBinding.ensureInitialized();

  /// 使用await保证应用初始化
  await RsxInit.init(preBuiltinInit: () {
    Routes.initGlobalRoutes();
  }, postBuiltinInit: () {
    BusinessProviders.initBusinessProviders();
    LogUtils.d('initial end');
  });

  runApp(const OKToast(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Provides.provide(HomepageLogic());
    return Scaffold(
      appBar: RsxAppBar(
        leadingWidget: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: Icon(
            Icons.adb,
            color: Colors.green,
          ),
        ),
        title: widget.title,
        isBack: false,
        backgroundColor: Colors.grey.withOpacity(0.1),
      ),
      body: HomepagePage(),
    );
  }
}
