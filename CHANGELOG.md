## 0.0.4

## 0.0.3
**>> BREAKING CHANGE VERSION <<**
* 提供 `RSxInit.init(Function() preBuiltinInit, Function() postBuiltinInit)` 项目初始化
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
