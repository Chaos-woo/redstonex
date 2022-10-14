import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// A directory function set.
///
class DirectoryHelper {
  /// temporary directory
  static Directory? temporaryDirectory;

  /// app directory
  static late Directory appDirectory;

  /// external directory for android
  static Directory? externalDirectory;

  /// Initial directory information
  ///
  /// Need call [initialize] method before using path
  static Future<void> initialize() async {
    temporaryDirectory = await getTemporaryDirectory();
    appDirectory = await getApplicationDocumentsDirectory();
    if (Platform.isAndroid) {
      externalDirectory = await getExternalStorageDirectory();
    }
  }
}
