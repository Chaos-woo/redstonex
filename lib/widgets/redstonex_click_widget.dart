import 'package:flutter/material.dart';
import 'package:redstonex/extension/function_extension.dart';

enum ClickType { none, throttle, throttleWithTimeout, debounce }

class RsxClickWidget extends StatelessWidget {
  final Widget child;
  final Function? onTap;
  final ClickType type;
  final int? timeout;
  bool? clickEffect;

  RsxClickWidget({
    Key? key,
    required this.child,
    this.onTap,
    this.type = ClickType.throttle,
    this.timeout,
    this.clickEffect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (clickEffect ?? false)
        ? InkWell(
      onTap: _getOnTap(),
      child: child,
    )
        : GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _getOnTap(),
      child: child,
    );
  }

  VoidCallback? _getOnTap() {
    if (type == ClickType.throttle) {
      return onTap?.throttle();
    } else if (type == ClickType.throttleWithTimeout) {
      return onTap?.throttleWithTimeout(timeout: timeout);
    } else if (type == ClickType.debounce) {
      return onTap?.debounce(timeout: timeout);
    }
    return () => onTap?.call();
  }
}
