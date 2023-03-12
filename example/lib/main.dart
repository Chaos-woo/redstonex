import 'package:example/db-manager/example_base_floor_database.dart';
import 'package:example/homepage/homepage/homepage_logic.dart';
import 'package:example/homepage/homepage/homepage_view.dart';
import 'package:example/net-manager/net_client_manager.dart';
import 'package:example/providers/providers_manager.dart';
import 'package:example/routes.dart';
import 'package:example/services/services_manager.dart';
import 'package:flustars_flutter3/flustars_flutter3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:redstonex/redstonex.dart';

void main() async {
  // /// Flutter组件绑定必须
  // WidgetsFlutterBinding.ensureInitialized();
  //
  // /// 使用await保证应用初始化
  // await RsxInitializer.init(preBuiltinInit: () {
  //   Routes.initGlobalRoutes();
  //   MyExampleDb().initializeDatabase();
  // }, postBuiltinInit: () {
  //   NetClientManager.initNetClients();
  //   ProvidersManager.initProviders();
  //   ServicesManager.initServices();
  //   ScreenUtil.getInstance();
  //   XLog().debug('initial end');
  // });
  //
  // runApp(const OKToast(child: MyApp()));

  AppInitializer.run(
    const OKToast(child: MyApp()),
    preBuiltinInit: () {
      Routes.initGlobalRoutes();
      MyExampleDb().initializeDatabase();
    },
    postBuiltinInit: () {
      NetClientManager.initNetClients();
      ProvidersManager.initProviders();
      ServicesManager.initServices();
      ScreenUtil.getInstance();
      XLog().debug('initial end');
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Flutter Demo',
      getPages: XDispatcher.pageRoutes,
      theme: ThemeData(
        primaryColor: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      builder: EasyLoading.init(),
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
    XProvides().provide(HomepageLogic());
    return Scaffold(
      appBar: RsxAppBar(
        leading: const Padding(
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
