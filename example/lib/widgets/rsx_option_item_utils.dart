import 'package:flutter/material.dart';
import 'package:redstonex/redstonex.dart';
import 'package:styled_widget/styled_widget.dart';

class RsxOptionItemUtils {
  static rHorizontalItem navigatorRsxOptionItem({
    required String title,
    required String description,
    VoidCallback? onTap,
  }) {
    return rHorizontalItem(
      title: title,
      titleStyle: const TextStyle(fontSize: 16),
      description: Text(
        description,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
      ),
      leading: const Icon(
        Icons.contact_page,
        size: 20,
        color: Colors.grey,
      ).padding(right: 10),
      suffix: const Icon(
        Icons.keyboard_arrow_right,
        size: 20,
        color: Colors.grey,
      ),
      onTap: onTap,
      backgroundColor: Colors.white,
    );
  }

  static rHorizontalItem functionRsxOptionItem({
    required String title,
    required String description,
    VoidCallback? onTap,
  }) {
    return rHorizontalItem(
      title: title,
      titleStyle: const TextStyle(fontSize: 16),
      description: Text(
        description,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
      ),
      leading: const Icon(
        Icons.ads_click,
        size: 20,
        color: Colors.grey,
      ).padding(right: 10),
      onTap: onTap,
      backgroundColor: Colors.white,
    );
  }
}
