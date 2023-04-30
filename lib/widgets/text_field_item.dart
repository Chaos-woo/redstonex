import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../resources/gaps.dart';
import '../utils/input_formatter/number_text_input_formatter.dart';

/// 封装输入框
class TextFieldItem extends StatelessWidget {
  const TextFieldItem({
    super.key,
    this.controller,
    this.title = '',
    this.titleStyle,
    this.keyboardType = TextInputType.text,
    this.hintText = '',
    this.hintStyle,
    this.focusNode,
  });

  final TextEditingController? controller;
  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final TextStyle? titleStyle;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    final Row child = Row(
      children: <Widget>[
        if (title.isNotEmpty) ...[Text(title), Gaps.hGap16],
        Expanded(
          child: Semantics(
            label: hintText.isEmpty ? '' : hintText,
            child: TextField(
              focusNode: focusNode,
              keyboardType: keyboardType,
              inputFormatters: _getInputFormatters(),
              controller: controller,
              style: titleStyle,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none, //去掉下划线
                hintStyle: hintStyle,
              ),
            ),
          ),
        ),
        Gaps.hGap16
      ],
    );

    return Container(
      height: 50.0,
      margin: const EdgeInsets.only(left: 16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: Divider.createBorderSide(context, width: 0.6),
        ),
      ),
      child: child,
    );
  }

  List<TextInputFormatter>? _getInputFormatters() {
    if (keyboardType == const TextInputType.numberWithOptions(decimal: true)) {
      return <TextInputFormatter>[UsNumberTextInputFormatter()];
    }
    if (keyboardType == TextInputType.number || keyboardType == TextInputType.phone) {
      return <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly];
    }
    return null;
  }
}
