import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yourlucky/src/B_UI/Common/Widget/Button/SAUButtonModel.dart';
import 'SAUDividerView.dart';

typedef ButtonRowsButtonClick = Function(SAUButtonModel value);

class SAUButtonRowsView extends StatelessWidget {
  final List<SAUButtonModel> buttonList;
  final ButtonRowsButtonClick onButtonTap;
  final bool showDivider;

  SAUButtonRowsView(
      {required this.buttonList,
        required this.onButtonTap,
        this.showDivider = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Offstage(offstage: !showDivider, child: SAUDividerView()),
          Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                textDirection: TextDirection.ltr,
                children: _buildButtons(),
              )),
        ],
      ),
    );
  }

  List<Widget> _buildButtons() {
    var buttons = List<Widget>.empty(growable: true);
    buttonList.forEach((element) {
      final backColor =
      element.highLight ? Color(0xFFFEAB00) : Colors.transparent;
      final textColor = element.highLight ? Colors.white : Color(0xFF333333);
      final bolderColor =
      element.highLight ? Colors.transparent : Color(0xFFDCDFE6);
      buttons.add(Container(
          height: 30,
          padding: EdgeInsets.only(left: 8),
          child: Center(
            child: Material(
              shape: StadiumBorder(
                side: BorderSide(
                  width: 0.5,
                  color: bolderColor,
                ),
              ),
              clipBehavior: Clip.hardEdge,
              color: backColor,
              child: InkWell(
                  onTap: () => {onButtonTap(element)},
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    constraints: BoxConstraints(minWidth: 80),
                    height: 30,
                    child: Center(
                      child: Text(element.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: textColor,
                          )),
                    ),
                  )),
            ),
          )));
    });
    return buttons;
  }
}
