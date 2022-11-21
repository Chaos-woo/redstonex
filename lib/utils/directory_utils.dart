import 'dart:io';

import 'package:path_provider/path_provider.dart';

class DirectoryUtils {
  /// temporary directory
  static Directory? temporaryDir;

  /// app directory
  static late Directory appDir;

  /// external directory for android
  static Directory? externalDir;

  /// Initial directory information
  ///
  /// Need call [init] method before using path
  static Future<void> init() async {
    temporaryDir = await getTemporaryDirectory();
    appDir = await getApplicationDocumentsDirectory();
    if (Platform.isAndroid) {
      externalDir = await getExternalStorageDirectory();
    }
  }
}
