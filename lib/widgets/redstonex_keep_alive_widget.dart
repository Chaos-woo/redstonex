import 'package:flutter/material.dart';

class RsxKeepAliveWidget extends StatefulWidget {
  final Widget child;

  const RsxKeepAliveWidget(this.child, {Key? key}) : super(key: key);

  @override
  State<RsxKeepAliveWidget> createState() => _RsxKeepAliveWidgetState();
}

class _RsxKeepAliveWidgetState extends State<RsxKeepAliveWidget> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
