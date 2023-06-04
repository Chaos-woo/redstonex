# Redstonex
基于GetX的Flutter项目快速开发框架。
Fast development framework of flutter project based on GetX.

## Features

* 工具使用和网络数据处理：参考example/lib/homepage/
* Dio集成后的使用：参考example/lib/net-manager/
* floor集成后的sqlite数据库使用：参考example/lib/db-manager/
* 路由使用参考：参考example/lib/routes.dart
* 启动main：参考example/lib/main.dart

## Usage

* 安装 - 使用最新版本
```yaml
dependencies:
  redstonex: any
```

* 模板初始化
```dart
void main() async {
  rApplicationInitializer.run(
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
      rLog().debug('initial end');
    },
    errorReporter: (details) => FlutterError.dumpErrorToConsole(details),
  );
}
```

## Change log
见 [CHANGELOG.md](https://github.com/Chaos-woo/redstonex/blob/master/CHANGELOG.md)
