
import 'package:example/net-manager/bili/bili_net_client.dart';
import 'package:example/net-manager/jvhe/jvhe_net_client.dart';
import 'package:redstonex/redstonex.dart';

class NetClientManager {
  static void initNetClients() {
    XProvides().provide(JvheNetClient());
    XProvides().provide(BiliNetClient());
  }
}