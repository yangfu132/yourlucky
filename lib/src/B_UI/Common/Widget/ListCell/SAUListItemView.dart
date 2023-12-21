import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SAUListItemView extends StatelessWidget {
  final String title;
  final String content;
  String? secondContent;
  double titleWidth = 104;
  bool contentMultiline = false;
  bool secondEllipsis = true;

  SAUListItemView(
      {required this.title,
        required this.content,
        this.secondContent,
        this.titleWidth = 104,
        this.contentMultiline = false,
        this.secondEllipsis = true});

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.ideographic,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          constraints: BoxConstraints(minWidth: titleWidth),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContent(),
              Offstage(
                offstage: secondContent == null,
                child: secondEllipsis
                    ? Text(secondContent ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF999999),
                    ))
                    : Text(secondContent ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF999999),
                    )),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildContent() {
    late Widget ret;
    if (!contentMultiline) {
      ret = Text(content,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF333333),
          ));
    } else {
      ret = Text(content,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF333333),
          ));
    }
    return ret;
  }
}
