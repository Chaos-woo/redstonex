## 1.2.1
* 更新RsxTextBottomNavigationBarPage组件，支持更多自定义属性设置
* 增加ExtDouble扩展，支持EdgeInsetsGeometry快速设置

## 1.2.0
* 缓存组件更名为XShared，支持获取缓存中基本类型列表
* 更新依赖persistent_bottom_nav_bar_v2升级至^5.0.0-beta.5，支持floatingActionButtonLocation
* 更新LottieGetxBottomNavigationBarPage、RsxTextBottomNavigationBarPage组件，支持更多自定义属性设置
* 更新RsxAppBar组件，支持更多自定义属性设置

## 1.1.11
* 修复xInject_中lazy*方法注入提前初始化GetxController或GetxService
* RefreshableWidgets组件增加跟随列表滑动的前置组件和后置组件

## 1.1.10
* 修复EventPagingController的RefreshController未初始化的问题
* 增加Dio流式响应
* 增加Dio SSE（Server Send Event）支持

## 1.1.9
**>> BREAKING CHANGE VERSION <<**
* 优化HasPagingEventEmitter及传递的事件类型
* 增加非EventPagingController使用事件传递方法扩展HasEventEmitter
* 移除原有的RsxException内部异常类
* 简化并语义化GetxService和GetxController的注入和依赖类my_getx_extension
* PagingController增加@Deprecated标签，推荐使用Event事件传递方式解耦页面logic与服务上下层或服务之间的依赖
* 全局配置中增加异常提示文案；全局配置中增加http业务自定义处理
* 优化部分类/文件名

## 版本号更新异常😢
~~1.1.8~~<br>
~~修复PagingController中提供的RefreshController初始化状态异常~~<br>
~~PagingController支持自定义RefreshController~~<br>
~~增加GenericPersistentHeaderBuilder~~<br>

## 1.1.7
* 修复PagingController中提供的RefreshController初始化状态异常
* PagingController支持自定义RefreshController
* 增加GenericPersistentHeaderBuilder

## 1.1.6
* 修复BaseDao提供的list方法

## 1.1.5
* 移除keyboard_action三方包

## 1.1.4
* 增加BaseDao提供的基础查询方法
* 移除多余的dart_tuple三方库

## 1.1.3
* 修复JsonSerializable类型转换器const构造函数作为注解使用方式的语法错误

## 1.1.2
* 增加支持Lottie动画的Bottom Navigation Bar-PageView
* 增加persistent_bottom_nav_bar_v2三方库的文字Bottom Navigation Bar-PageView

## 1.1.1
* 增加 `<String, dynamic>` 类型map扩展方法

## 1.1.0
* 增加权限申请插件工具类
* 优化内部工具类启动方法名
* 移除不需要的三方插件库

## 1.0.10
* PageController2#loadData方法返回值类型调整

## 1.0.9
* 增加PagingController滚动至顶部并刷新接口
* 支持HttpClient代理设置
* 支持HttpClient请求取消CancelToken
* 优化网络监听工具处理

## 1.0.8
* 增加json_serializable默认数据转换类

## 1.0.7
* 完善CHANGE LOG

## 1.0.6
* 增加 `RsxKeepAliveWidget` 组件

## 1.0.5
* 增加RawData类扩展操作，使其更方便处理内部dynamic类型数据
* 移除FlutterJsonBeanFactory插件生成fromJson、toJson方法
* 增加依赖@JsonSerializable()三方库管理POJOs的fromJson、toJson方法
* 修复example示例中json转换插件更换引起的POJOs转换问题

## 1.0.4
* 增加列表控制器item项局部更新
* 增加dialog仅有操作按钮的场景
* 完善用例数据库的使用

## 1.0.3
* 优化类名

## 1.0.2
* 优化UI事件更新
* 优化HttpOption复制操作

## 1.0.1
* 优化应用初始化器
* 优化Flutter全局异常捕获器

## 1.0.0
**>> BREAKING CHANGE VERSION <<**
* 引入flutter BloC思想和Cubit简化Block的编写方法，结合GetX状态管理，优化RSX框架的UI刷新机制
* 充分利用 `XEventBus` 流监听和GetX的Controller生命周期，完善事件-UI通知机制
* 使用新UI刷新机制重写PagingController2，并增加对应的example用例
* 优化所有类名

## 0.0.9
* 完善example用例，全面测试框架

## 0.0.8
**>> BREAKING CHANGE VERSION <<**
* 优化所有类名

## 0.0.7
**>> BREAKING CHANGE VERSION <<**
* 优化 `redstonex_button` 组件工具
* 优化 `redstonex_scroll_view` 组件工具
* 移除部分不需要的内置widget

## 0.0.6
**>> BREAKING CHANGE VERSION <<**
* 优化 `RsxOptionGroupWidget` 组件工具
* 移除部分不需要的内置widget

## 0.0.5
**>> BREAKING CHANGE VERSION <<**
* 毁灭性地优化了`DialogUtils`、`ToastUtils`、`SnackBarUtils`、`BottomSheetUtils`工具
* 增加int扩展，处理数字向Duration转换
* 优化了RedstoneX的内部工具初始化顺序
* 修复了`OptionBarGroup` 相关组件的展示BUG，增加主组件和扩展组件的比例自动调整

## 0.0.4
* 优化sqflite数据升级回调
* 封装GetX的dialog、snackbar、bottomsheet小工具
* 增加内置的widget，大部分源自 [flutter_deer项目](https://github.com/simplezhli/flutter_deer)
* 移除基于 `reflectable` 的反射框架，移除所有可反射注解处理代码
* 增加widget_chain空安全工具
* 增加string、list扩展小工具

## 0.0.3
**>> BREAKING CHANGE VERSION <<**
* 提供 `RSxInit.init(Function()? preBuiltinInit, Function()? postBuiltinInit)` 项目初始化
* 提供 `Dispatcher.init()` 初始化基于GetX的项目路由
* 提供 `GlobalConfig` 配置项目全局配置，可进行个性化配置
* 提供 `EBus` 基于dart的stream事件流消息处理
* 提供 `Mcg` 和 `Pcg` 基于get_storage和shared_preferences的内存缓存和项目本地缓存
* 提供 `RequestClient` 基于dio的网络请求客户端，支持设置全局loading
* 提供 `BaseRepository` 基于floor的sqlite本地数据库客户端框架
* 提供 `PagingController`、`RefreshWidgets`等分页数据状态管理处理框架
* 提供一揽子小工具

## 0.0.2
* (**obsolete**)重构基于dio和retrofit的网络框架封装，使用更简单的代码编写dio拦截器
* (**obsolete**)新增基于get_storage的内存KV存储和本地文件KV存储，支持用户使用其他三方库替换
* (**obsolete**)log、stands等文件包路径重写，简化代码分包
* (**obsolete**)重写网络异常处理，网络错误由dio拦截器处理，业务错误码由下游继续处理

## 0.0.1
* 提供基础的基于get的容器管理，实现app的状态管理器
* (**obsolete**)提供基础的基于reflectable框架的自定义容器管理，实现基于注解的简单容器自动注入管理
* 提供基础的基于get的路由辅助工具
* (**obsolete**)提供基础的基于dio和retrofit的网络框架封装
* 提供基础的基于event_bus的事件流监听辅助工具
* (**obsolete**)提供基础的基于get_storage的简单内存、本地存储
