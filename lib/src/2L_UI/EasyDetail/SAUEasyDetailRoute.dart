import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourlucky/src/1L_Context/SACContext.dart';
import 'package:yourlucky/src/2L_UI/EasyDetail/SAUSubDetailRoute.dart';

import '../../3L_Business/EasyDetail/SABEasyDetailModel.dart';

class SAUEasyDetailRoute extends StatefulWidget {
  SAUEasyDetailRoute(this.inputDetailModel);
  final SABEasyDetailModel inputDetailModel;

  @override
  _SAUEasyDetailRouteState createState() {
    return _SAUEasyDetailRouteState();
  }
}

class _SAUEasyDetailRouteState extends State<SAUEasyDetailRoute> {
  @override
  void initState() {
    super.initState();
  }

  SABEasyDetailModel detailModel() {
    return widget.inputDetailModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(detailModel().stringDetailName),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              SACContext.easyStore().addDigitModel(detailModel().digitModel());
            },
            child: Text('保存'),
            style: SACContext.textButtonStyle(),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    List listDetail = detailModel().detailList();
    List<Widget> listRow = [];
    int intCount = listDetail.length;
    for (int intIndex = 0; intIndex < intCount; intIndex++) {
      if (0 == intIndex) {
        listRow.add(getTitleRowWidget(listDetail[intIndex]));
      } else {
        listRow.add(
            getContentRowWidget(intIndex, listDetail[0], listDetail[intIndex]));
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
            return SAUSubDetailRoute(widget.inputDetailModel, 0);
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
  Widget getContentRowWidget(
      int intIndex, List<String> listTitle, List<String> listContent) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SAUSubDetailRoute(widget.inputDetailModel, intIndex);
          }));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(width: 1, color: Color(0xffe5e5e5)),
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
          padding: EdgeInsets.only(left: 5.0, right: 5.0),
          foregroundDecoration: BoxDecoration(
            border: Border(
              right: BorderSide(width: 1, color: Color(0xffe5e5e5)),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                stringItem,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 5),
              )
            ],
          ),
        ),
      ),
    );
  }
}
