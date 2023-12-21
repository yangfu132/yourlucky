import 'package:flutter/material.dart';
import 'SAUBottomButtonBarModel.dart';
import 'SAUButtonModel.dart';

///功能：显示策略推断结果
class SAUBottomButtonBar extends StatefulWidget {
  SAUBottomButtonBar({required this.model,required this.onTap});
  final SAUBottomButtonBarModel model;
  final ButtonTapCallback onTap;
  @override
  _SAUBottomButtonBarState createState() {
    return _SAUBottomButtonBarState();
  }
}

class _SAUBottomButtonBarState extends State<SAUBottomButtonBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    final buttons = widget.model.itemList;
    final lastIndex = buttons.length - 1;
    for (int i = 0; i < buttons.length; i++) {
      SAUButtonModel item = widget.model.itemList[i];
      children.add(_buildButton(item, i == lastIndex));
      if (i != lastIndex) {
        children.add(SizedBox(width: 10));
      }
    }

    return Container(
      height: 65,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x1a0E567F),
            blurRadius: 10.0,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Row(children: children),
    );
  }

  Widget _buildButton(SAUButtonModel item,bool isLast) {
    final backColor = isLast ? Color(0xFFFEAB00) : Colors.white;
    final borderColor = isLast ? Color(0xFFFEAB00) : Color(0xFFDCDFE6);
    final textColor = isLast ? Colors.white : Colors.black;
    return Expanded(
      child: Material(
        shape: StadiumBorder(
          side: BorderSide(
            width: 0.5,
            color: borderColor,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        color: backColor,
        child: InkWell(
          onTap: () {widget.onTap(item);},
          child: Center(
            child: Text(
              item.title,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
