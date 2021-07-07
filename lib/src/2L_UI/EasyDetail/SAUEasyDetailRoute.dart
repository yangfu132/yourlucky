import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourlucky/src/2L_UI/EasyResult/SAUEasyResultRoute.dart';

import '../../3L_Business/EasyBasic/SABEasyDigitModel.dart';
import '../../3L_Business/EasyDetail/SABEasyDetailBusiness.dart';
import '../../3L_Business/EasyDetail/SABEasyDetailModel.dart';

class SAUEasyDetailRoute extends StatefulWidget {
  SAUEasyDetailRoute(this.inputEasyModel);
  final SABEasyDigitModel inputEasyModel;

  @override
  _SAUEasyDetailRouteState createState() {
    return _SAUEasyDetailRouteState();
  }
}

class _SAUEasyDetailRouteState extends State<SAUEasyDetailRoute> {
  late final SABEasyDetailBusiness detailBusiness =
      SABEasyDetailBusiness(widget.inputEasyModel);

  @override
  void initState() {
    super.initState();
  }

  SABEasyDetailModel detailModel() {
    return detailBusiness.outputDetailModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(detailModel().stringDetailName),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    List listDetail = detailModel().detailList();
    List<Widget> listRow = [];
    int intCount = listDetail.length;
    for (int intRow = 0; intRow < intCount; intRow++) {
      if (0 == intRow) {
        listRow.add(getTitleRowWidget(listDetail[intRow]));
      } else {
        listRow.add(getContentRowWidget(listDetail[0], listDetail[intRow]));
      }
    }

    return Column(
      children: listRow,
    );
  }

  ///顶部标题行
  Widget getTitleRowWidget(List<String> listTitle) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SAUEasyResultRoute(widget.inputEasyModel);
          }));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffeeeeee),
            border: Border(
              bottom: BorderSide(width: 1, color: Color(0xffe5e5e5)),
            ),
          ),
          // child: Text("text"),
          child: Row(
            children: getSymbolList(listTitle, listTitle),
          ),
        ),
      ),
    );
  }

  ///内容行
  Widget getContentRowWidget(List<String> listTitle, List<String> listContent) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SAUEasyResultRoute(widget.inputEasyModel);
          }));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(width: 1.w, color: Color(0xffe5e5e5)),
            ),
          ),
          // child: Text("text"),
          child: Row(
            children: getSymbolList(listTitle, listContent),
          ),
        ),
      ),
    );
  }

  List<Widget> getSymbolList(final listTitle, final listContent) {
    List<Widget> result = [];
    for (int nColumn = 0; nColumn < listContent.length; nColumn++) {
      Widget widgetItem = getSymbolWidget(
        listTitle[nColumn],
        listContent[nColumn],
      );
      result.add(widgetItem);
    }
    return result;
  }

  Widget getSymbolWidget(String stringTitle, String stringItem) {
    int weight = stringTitle.length;
    return Expanded(
      flex: weight,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: double.infinity),
        child: Container(
          padding: EdgeInsets.only(left: 5.0.w, right: 5.0.w),
          foregroundDecoration: BoxDecoration(
            border: Border(
              right: BorderSide(width: 1.w, color: Color(0xffe5e5e5)),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                stringItem,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 5.w),
              )
            ],
          ),
        ),
      ),
    );
  }
}
