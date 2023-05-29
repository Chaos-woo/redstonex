import 'dart:io';

import 'package:path_provider/path_provider.dart';

class rDirectory {
  static final rDirectory _single = rDirectory._internal();

  rDirectory._internal();

  factory rDirectory() => _single;

  /// 临时目录
  late Directory temporaryDirectory;

  /// 应用支持文件目录，不暴露给用户
  late Directory applicationInnerSupportDirectory;

  /// 存放用户数据文件目录，用户可查看
  late Directory applicationDataDirectory;

  Future<void> initial() async {
    /// 未备份的临时目录的路径
    temporaryDirectory = await getTemporaryDirectory();

    /// 存放应用支持文件目录
    applicationInnerSupportDirectory = await getApplicationSupportDirectory();

    /// 存放用户数据文件目录
    applicationDataDirectory = await getApplicationDocumentsDirectory();
  }
}
