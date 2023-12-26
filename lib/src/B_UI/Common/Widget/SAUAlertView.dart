import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yourlucky/src/B_UI/Common/SAUCommonColor.dart';

class SAUAlertAction {
  final String title;

  ///action会在pop之后调用，允许为null
  final VoidCallback? action;
  final bool isDefault;

  final bool isColorGrey;

  ///该值不为null时，将不会自动调用pop
  final VoidCallback? popAction;
  SAUAlertAction({
    required this.title,
    this.action,
    this.popAction,
    this.isDefault = false,
    this.isColorGrey = false,
  });
}

///统一使用二次封装后的弹框
class SAUAlertWidget {
  static void showTitle(
      BuildContext context, String title, List<SAUAlertAction> actions,
      {TextStyle? titleStyle}) {
    showCustom(
        context,
        Text(
          title,
          style: titleStyle ?? TextStyle(fontWeight: FontWeight.normal),
        ),
        null,
        actions);
  }

  static void showMessage(BuildContext context, String title, String message,
      List<SAUAlertAction> actions) {
    showCustom(
        context,
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(message, style: TextStyle(fontWeight: FontWeight.normal)),
        actions);
  }

  static void showCustom(BuildContext context, Widget title, Widget? content,
      List<SAUAlertAction> actions) {
    final alertActions = actions.map((action) {
      return CupertinoDialogAction(
        onPressed: () {
          if (action.popAction == null) {
            Navigator.of(context).pop();
          } else {
            action.popAction!();
          }
          action.action?.call();
        },
        isDefaultAction: action.isDefault,
        child: Text(
          action.title,
          style: TextStyle(
              color: action.isColorGrey
                  ? SAUCommonColor.regularText
                  : SAUCommonColor.alertButton),
        ),
      );
    }).toList();
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
              title: title, content: content, actions: alertActions);
        });
  }
}
