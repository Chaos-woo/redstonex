import 'package:flutter/material.dart';

class RsxKeepAliveWrapper extends StatefulWidget {
  final Widget child;

  const RsxKeepAliveWrapper({Key? key, required this.child}) : super(key: key);

  @override
  State<RsxKeepAliveWrapper> createState() => _RsxKeepAliveWrapperState();
}

class _RsxKeepAliveWrapperState extends State<RsxKeepAliveWrapper> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
