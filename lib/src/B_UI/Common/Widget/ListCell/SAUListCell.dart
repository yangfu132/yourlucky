import 'package:flutter/material.dart';
import 'package:yourlucky/src/B_UI/Common/Widget/Button/SAUBottomButtonBarModel.dart';
import 'package:yourlucky/src/B_UI/Common/Widget/Button/SAUButtonModel.dart';
import 'SAUButtonRowsView.dart';
import 'SAUDividerView.dart';
import 'SAUImageInputView.dart';
import 'SAUListCellModel.dart';
import 'SAUListItemView.dart';

typedef ListCellClick = Function(SAUListCellModel model);


///功能：显示策略推断结果
class SAUListCell extends StatefulWidget {
  SAUListCell({required this.model,required this.onTap,required this.buttonsClick});
  final SAUListCellModel model;
  final ListCellClick onTap;
  final ButtonTapCallback? buttonsClick;
  @override
  _SAUListCellState createState() {
    return _SAUListCellState();
  }
}

class _SAUListCellState extends State<SAUListCell> {
  @override
  void initState() {
    super.initState();
  }

  bool get haveTitle {
    var ret = false;
    if (widget.model.title.isNotEmpty) {
      ret = true;
    }
    if (widget.model.tips != null && widget.model.tips!.isNotEmpty) {
      ret = true;
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              //阴影
              BoxShadow(
                  color: Color(0x270E567F),
                  offset: Offset(0, 0),
                  blurRadius: 10,
                  spreadRadius: 0)
            ],
            borderRadius: BorderRadius.circular(6)),
        margin: EdgeInsets.only(),
        child: InkWell(
          onTap: () => {_cellClick()},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: _buildBody(context),
          ),
        ),
      ),
    );
  }

  void _cellClick() {
    widget.onTap(widget.model);
  }

  void _buttonClick(SAUButtonModel value) {
    if (widget.buttonsClick != null) {
      widget.buttonsClick!(value);
    }
    widget.onTap(widget.model);
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        _buildTitleBar(),
        _buildContents(),
        _buildButtons(),
      ],
    );
  }

  Widget _buildContents() {
    var childs = <Widget>[];
    childs.add(Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: _buildContent()));
    if (!haveTitle && widget.model.showStatus) {
      childs.add(_buildTitle());
    }
    return Stack(
      children: childs,
    );
  }

  Widget _buildButtons() {
    if (widget.model.buttons.isNotEmpty) {
      return SAUButtonRowsView(
          showDivider: true,
          buttonList: widget.model.buttons,
          onButtonTap: (value) => {_buttonClick(value)});
    } else {
      return Container(
        height: 5,
      );
    }
  }

  Widget _buildTitleBar() {
    if (!haveTitle) {
      return Container(
        height: 5,
      );
    } else {
      return _buildTitle();
    }
  }

  Widget _buildTitle() {
    var haveDivider = haveTitle ? true : false;
    double titleWidth = widget.model.showStatus ? 260 : 320;
    double titleFontSize = widget.model.title.isNotEmpty ? 16 : 14;
    var title = widget.model.title.isNotEmpty ? widget.model.title : widget.model.tips;
    var titleColor =
    widget.model.title.isNotEmpty ? Color(0xFF000000) : Color(0xFF666666);
    var titleFont =
    widget.model.title.isNotEmpty ? FontWeight.w500 : FontWeight.normal;
    var tips = widget.model.title.isNotEmpty ? widget.model.tips : null;
    title ??= '';
    return Container(
      padding: EdgeInsets.only(top: 12, bottom: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: titleWidth,
                child: Text(title,
                    //maxLines: 2,
                    //overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: titleFont,
                      color: titleColor,
                    )),
              ),
              Expanded(child: Container()),
              Offstage(
                  offstage: widget.model.showStatus,
                  child: Text(widget.model.statusStr ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: widget.model.statusStrColor))),
            ],
          ),
          Offstage(
              offstage: tips == null,
              child: Container(
                padding: EdgeInsets.only(top: 8, bottom: 0),
                child: Text(tips ?? '',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF666666))),
              )),
          SizedBox(
            height: 12,
          ),
          Offstage(
            offstage: !haveDivider,
            child: SAUDividerView(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    var list = List<Widget>.empty(growable: true);
    widget.model.contents.forEach((element) {
      if (element.type == SAUListCellModelItemType.keyValue) {
        var item = SAUListItemView(title: element.title, content: element.content);
        if (element.secondContent != null) {
          item.secondContent = element.secondContent;
        }
        item.contentMultiline = element.contentMultiline;
        item.titleWidth = element.titleWidth;
        item.secondEllipsis = element.secondEllipsis;
        list.add(item);
      } else if (element.type == SAUListCellModelItemType.picture) {
        var item = SAUImageInputView(
          title: element.title,
          isEdit: false,
          urls: [element.content],
          padding: EdgeInsets.symmetric(vertical: 5),
          imagePadding: EdgeInsets.only(top: 0, bottom: 3),
        );
        list.add(item);
      }
    });
    return Column(
      children: list,
    );
  }
}
