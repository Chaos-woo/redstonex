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

* install sdk
```yaml
dependencies:
  redstonex: ^1.0.4
```

* 模板初始化
```dart
void main() async {
  /// 封装通常的app启动配置过程
  AppInitializer.run(
    const OKToast(child: MyApp()),
    /// 内部初始化前
    preBuiltinInit: () {
      /// App路由初始化
      Routes.initGlobalRoutes();
      /// 数据库初始化
      MyExampleDb().initializeDatabase();
    },
    /// 内部初始化后
    postBuiltinInit: () {
      /// 业务service初始化
      NetClientManager.initNetClients();
      ProvidersManager.initProviders();
      ServicesManager.initServices();
      
      ScreenUtil.getInstance();
      XLog().debug('initial end');
    },
    /// flutter顶级异常处理器
    errorReporter: (details) {},
  );
} 
```

## Change log
见 [CHANGELOG.md](https://github.com/Chaos-woo/redstonex/blob/master/CHANGELOG.md)
