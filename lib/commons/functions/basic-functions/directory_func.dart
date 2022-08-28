import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// A directory function set.
///
class DirectoryFunc {
  /// temporary directory
  static Directory? temporaryDirectory;

  /// app directory
  static late Directory appDirectory;

  /// external directory for android
  static Directory? externalDirectory;

  /// Initial directory information
  ///
  /// Need call [initial] method before using path
  static Future<void> init() async {
    temporaryDirectory = await getTemporaryDirectory();
    appDirectory = await getApplicationDocumentsDirectory();
    if (Platform.isAndroid) {
      externalDirectory = await getExternalStorageDirectory();
    }
  }
}
