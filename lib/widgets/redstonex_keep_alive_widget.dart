import 'package:flutter/material.dart';

class rKeepAliveWidget extends StatefulWidget {
  final Widget child;

  const rKeepAliveWidget(this.child, {Key? key}) : super(key: key);

  @override
  State<rKeepAliveWidget> createState() => _rKeepAliveWidgetState();
}

class _rKeepAliveWidgetState extends State<rKeepAliveWidget> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
