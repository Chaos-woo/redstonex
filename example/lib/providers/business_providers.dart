import 'package:example/providers/api_bug_provider.dart';
import 'package:redstonex/redstonex.dart';

class BusinessProviders {
  static void initBusinessProviders() {
    Provides.provide(ApiBugProvider());
  }
}
