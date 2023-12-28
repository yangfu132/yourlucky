import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yourlucky/src/B_UI/Common/Widget/SAUDividerView.dart';

import 'SAUDetailModel.dart';

class SAUDetailCell extends StatefulWidget {
  final SAUDetailModel model;

  const SAUDetailCell({required this.model})
      : super();

  @override
  _SAUDetailCellState createState() => _SAUDetailCellState();
}

class _SAUDetailCellState extends State<SAUDetailCell> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildViolationInfo(widget.model);
  }

  Widget _buildViolationInfo(SAUDetailModel model) {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleWithRightRow('违章信息', model),
          SAUDividerView(),
          SizedBox(height: 10),
          _buildInfoCell('分公司', '分公司' ?? '-', model),
          _buildInfoCell('违章条数','违章条数' ?? '-', model),
          _buildInfoCell('车牌前缀', '车牌前缀' ?? '-', model),
          _buildInfoCell('合计罚分', '合计罚分' ?? '-', model),
          _buildInfoCell('合计罚款', ('合计罚款' ?? '-'), model),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildTitleWithRightRow(String title, SAUDetailModel store) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Material(
            color: Colors.white,
            child: Row(
              children: [
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Color(0xFF333333),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfoCell(String title, String? detail, SAUDetailModel store) {
    String titleStr;
    String detailStr;
    if (detail != null && detail.isNotEmpty) {
      detailStr = detail;
    } else {
      detailStr = '-';
    }

    if (title.isNotEmpty) {
      titleStr = title;
    } else {
      titleStr = '-';
    }
    return _buildInfoDetailCell(titleStr, detailStr, 114, false, store);
  }


  Widget _buildInfoDetailCell(String title, String detail, double leftMargin,
      bool isShowCopyButton, SAUDetailModel store) {
    final children = <Widget>[
      Container(
        constraints: BoxConstraints(minWidth: leftMargin),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
          ),
        ),
      ),
      Expanded(
        child: Text(
          detail,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF333333),
          ),
        ),
      ),
    ];

    if (isShowCopyButton && detail.isNotEmpty && detail != '-') {
      children
          .add(Image.asset('assets/transport/image/transport_detail_copy.png'));
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.ideographic,
          children: children,
        ),
      ),
    );
  }


}
