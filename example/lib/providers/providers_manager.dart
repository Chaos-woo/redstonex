import 'package:example/providers/jvhe_api_provider.dart';
import 'package:redstonex/redstonex.dart';

class ProvidersManager {
  static void initProviders() {
    XProvides().provide(JvheApiProvider());
  }
}
