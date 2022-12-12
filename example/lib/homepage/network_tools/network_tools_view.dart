import 'package:flutter/material.dart';
import 'package:redstonex/redstonex.dart';

import 'network_tools_logic.dart';

class NetworkToolsComponent extends StatelessWidget {
  late final logic;
  late final state;

  NetworkToolsComponent({Key? key}) : super(key: key) {
    logic = Provides.provide(NetworkToolsLogic());
    state = Depends.on<NetworkToolsLogic>().state;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
