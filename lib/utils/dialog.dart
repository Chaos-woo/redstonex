import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import '../routes/router.dart';
import '../widgets/redstonex_click_widget.dart';
import 'shape_border.dart';
import 'theme.dart';

class DialogActionButton {
  final String text;
  double? fontSize;
  FontWeight? fontWeight;
  Color? buttonColor;
  Color? textColor;
  VoidCallback? onTap;

  DialogActionButton(
    this.text, {
    this.fontSize = 18.0,
    this.fontWeight,
    this.buttonColor,
    this.textColor = Colors.black,
    this.onTap,
  });
}

class XDialog {
  static final XDialog _single = XDialog._internal();

  XDialog._internal();

  factory XDialog() => _single;

  void showActionDialog(
    List<DialogActionButton> buttons, {
    bool divide = true,
    String? title,
    TextStyle? titleStyle,
    Color? backgroundColor,
    Color? buttonColor = Colors.transparent,
    WillPopCallback? onWillPop,
    bool barrierDismissible = true,
    Clip? dialogClipBehavior,
    ShapeBorder? dialogShape,
  }) async {
    Widget styledWidget(Widget child, bool isLast) => <Widget>[
          Styled.widget(child: child).padding(vertical: 3),
          if (divide && buttons.length > 1 && !isLast) const Divider(),
        ].toColumn();

    List<Widget> buttonWidgets = [];
    for (int i = 0; i < buttons.length; i++) {
      var b = buttons[i];
      TextStyle textStyle = TextStyle(
        fontSize: b.fontSize,
        fontWeight: b.fontWeight,
        color: b.textColor,
      );

      var widget = styledWidget(
          RsxClickWidget(
            onTap: () {
              XRouter.pop();
              b.onTap?.call();
            },
            clickEffect: true,
            child: <Widget>[
              Text(
                b.text,
                style: textStyle,
              )
            ].toRow(mainAxisAlignment: MainAxisAlignment.center),
          ),
          i == (buttons.length - 1));
      buttonWidgets.add(widget);
    }

    await _innerDialog(
      title: title,
      titleTextStyle: titleStyle,
      contentWidget: buttonWidgets.toColumn(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
      ),
      backgroundColor: backgroundColor,
      buttonColor: buttonColor,
      onWillPop: onWillPop,
      barrierDismissible: barrierDismissible,
      dialogClipBehavior: dialogClipBehavior,
      dialogShape: dialogShape ?? XShapeBorder().roundedRectangleBorder(radius: 10),
    );
  }

  Future<void> showPromptDialog<T>({
    String? title,
    TextStyle? titleStyle,
    Widget? contentWidget,
    String? content,
    TextStyle? contentStyle,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    Color? cancelTextColor,
    Color? confirmTextColor,
    String? textConfirm,
    String? textCancel,
    Color? backgroundColor,
    Color? buttonColor = Colors.transparent,
    WillPopCallback? onWillPop,
    bool barrierDismissible = true,
    List<Widget>? actions,
    Function(T? result)? callback,
    Clip? dialogClipBehavior,
    ShapeBorder? dialogShape,
  }) async {
    T? result = await _innerDialog(
      title: title,
      titleTextStyle: titleStyle,
      contentWidget: contentWidget,
      content: content,
      contentTextStyle: contentStyle,
      onConfirm: onConfirm,
      onCancel: onCancel,
      cancelTextColor: cancelTextColor,
      confirmTextColor: confirmTextColor,
      textConfirm: textConfirm,
      textCancel: textCancel,
      backgroundColor: backgroundColor,
      buttonColor: buttonColor,
      onWillPop: onWillPop,
      barrierDismissible: barrierDismissible,
      bottomActions: actions,
      dialogShape: dialogShape ?? XShapeBorder().roundedRectangleBorder(radius: 10),
      dialogClipBehavior: dialogClipBehavior,
    );
    callback?.call(result);
  }

  Widget dialogButton({
    required String text,
    TextStyle? textStyle,
    Color? buttonColor,
    Color? textColor,
    VoidCallback? onTap,
    double? buttonBorderRadius,
  }) {
    return TextButton(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: buttonColor ?? XTheme().theme().colorScheme.secondary,
        shape: null != buttonBorderRadius
            ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(buttonBorderRadius))
            : null,
      ),
      child: Text(
        text,
        style: textStyle ??
            TextStyle(color: textColor ?? XTheme().theme().primaryColor).merge(textStyle),
      ),
      onPressed: () => onTap?.call(),
    );
  }

  Widget textButton({
    required String text,
    TextStyle? textStyle,
    Color? buttonColor,
    Color? textColor,
    VoidCallback? onTap,
  }) {
    return TextButton(
      child: Text(
        text,
        style: textStyle ??
            TextStyle(color: textColor ?? XTheme().theme().primaryColor).merge(textStyle),
      ),
      onPressed: () => onTap?.call(),
    );
  }

  Future<void> showElasticDialog<T>({
    Widget? title,
    Widget? content,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    Color? cancelTextColor,
    Color? confirmTextColor,
    String? textConfirm,
    String? textCancel,
    Color? backgroundColor,
    Color? buttonColor = Colors.transparent,
    WillPopCallback? onWillPop,
    bool barrierDismissible = true,
    List<Widget>? actions,
    Function(T? result)? callback,
    Clip? dialogClipBehavior,
    ShapeBorder? dialogShape,
  }) async {
    T? result = await _innerDialog(
      titleWidget: title,
      contentWidget: content,
      onConfirm: onConfirm,
      onCancel: onCancel,
      cancelTextColor: cancelTextColor,
      confirmTextColor: confirmTextColor,
      textConfirm: textConfirm,
      textCancel: textCancel,
      backgroundColor: backgroundColor,
      buttonColor: buttonColor,
      onWillPop: onWillPop,
      barrierDismissible: barrierDismissible,
      bottomActions: actions,
      dialogClipBehavior: dialogClipBehavior,
      dialogShape: dialogShape ?? XShapeBorder().roundedRectangleBorder(radius: 10),
    );
    callback?.call(result);
  }

  Future<T?> _innerDialog<T>({
    String? title,
    String? content,
    TextStyle? titleTextStyle,
    TextStyle? contentTextStyle,
    Widget? titleWidget,
    Widget? contentWidget,
    Color? backgroundColor = Colors.white,
    bool barrierDismissible = true,
    WillPopCallback? onWillPop,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    Color? cancelTextColor,
    Color? confirmTextColor,
    String? textConfirm,
    String? textCancel,
    Color? buttonColor = Colors.transparent,
    List<Widget>? bottomActions,
    Clip? dialogClipBehavior,
    ShapeBorder? dialogShape,
  }) {
    if (title == null && content == null && titleWidget == null && contentWidget == null) {
      return Future.value(null);
    }

    List<Widget> actions = _buildBottomActions(
      textCancel: textCancel,
      textConfirm: textConfirm,
      onConfirm: onConfirm,
      onCancel: onCancel,
      buttonColor: buttonColor,
      confirmTextColor: confirmTextColor,
      cancelTextColor: cancelTextColor,
      bottomActions: bottomActions,
    );
    Widget alertDialog = AlertDialog(
      title: titleWidget ??
          Text(title ?? '', style: titleTextStyle, overflow: TextOverflow.ellipsis, maxLines: 1),
      content: contentWidget ?? Text(content ?? '', style: contentTextStyle),
      backgroundColor: backgroundColor,
      actions: actions,
      clipBehavior: dialogClipBehavior ?? Clip.none,
      shape: dialogShape,
      actionsPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
    );

    return Get.dialog<T>(
      onWillPop != null
          ? WillPopScope(
              onWillPop: onWillPop,
              child: alertDialog,
            )
          : alertDialog,
      barrierDismissible: barrierDismissible,
    );
  }

  List<Widget> _buildBottomActions({
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    Color? cancelTextColor,
    Color? confirmTextColor,
    String? textConfirm,
    String? textCancel,
    Color? buttonColor,
    List<Widget>? bottomActions,
  }) {
    if (bottomActions != null) {
      return bottomActions;
    }

    List<Widget> actions = [];
    if (textCancel != null) {
      actions.add(dialogButton(
        text: textCancel,
        textColor: cancelTextColor,
        onTap: onCancel,
        buttonColor: buttonColor,
      ));
    }
    if (textConfirm != null) {
      actions.add(dialogButton(
        text: textConfirm,
        textColor: confirmTextColor,
        onTap: onConfirm,
        buttonColor: buttonColor,
      ));
    }
    return actions;
  }
}
