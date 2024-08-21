import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SelectorInputView extends StatelessWidget {
  final String title;
  final String? content;
  final String placeHolder;
  final VoidCallback onTap;
  final double? titleMinWidth;

  SelectorInputView(
      {required this.title,
        required this.onTap,
        this.placeHolder = '请选择',
        this.content,
        this.titleMinWidth});

  TextStyle _placeholderStyle() {
    return TextStyle(
      fontSize: 25,
      color: Color(
        0xFFCCCCCC,
      ),
    );
  }

  TextStyle _textStyle() {
    return TextStyle(
      fontSize: 23,
      color: Color(0xFFE5CC69),
    );
  }

  Widget _buildSelector() {
    var text = (content == null ? placeHolder : content!);
    final style = (content != null ? _textStyle() : _placeholderStyle());
    return Row(
      children: [
        Spacer(),
        Text(text, style: style),
        // Spacer(),
        Icon(
          Icons.chevron_right,
          size: 27,
          color: Color(0xFFE5CC69),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        child: Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: Colors.transparent,
              radius: 0.0,
              onTap: () => onTap(),
              child: Row(
                children: [
                  Container(
                    constraints:
                    BoxConstraints(minWidth: titleMinWidth ?? 76),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 25,
                        color: Color(0xFFE5CC69),
                      ),
                    ),
                  ),
                  Expanded(child: _buildSelector()),
                ],
              ),
            )));
  }
}
