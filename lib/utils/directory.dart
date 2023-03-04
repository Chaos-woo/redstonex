import 'dart:io';

import 'package:path_provider/path_provider.dart';

class XDirectory {
  static final XDirectory _single = XDirectory._internal();

  XDirectory._internal();

  factory XDirectory() => _single;

  /// temporary directory
  Directory? temporaryDir;

  /// app directory
  late Directory appDir;

  /// external directory for android
  Directory? externalDir;

  /// Initial directory information
  ///
  /// Need call [init] method before using path
  Future<void> init() async {
    temporaryDir = await getTemporaryDirectory();
    appDir = await getApplicationDocumentsDirectory();
    if (Platform.isAndroid) {
      externalDir = await getExternalStorageDirectory();
    }
  }
}
