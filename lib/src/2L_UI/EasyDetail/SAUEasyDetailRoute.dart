import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourlucky/src/1L_Context/SACContext.dart';
import 'package:yourlucky/src/2L_UI/EasyDetail/SAUSubDetailRoute.dart';

import '../../4L_Business/EasyDetail/SABEasyDetailModel.dart';

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
    SystemChrome.setEnabledSystemUIOverlays([]);
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
              SACContext.easyStore().save(detailModel().digitModel());
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
    Map<String, List> mapResult = detailModel().detailList();
    List listKey = mapResult["key"]!;
    List listDetail = mapResult['value']!;
    List<Widget> listRow = [];

    int intCount = listDetail.length;
    for (int intIndex = 0; intIndex < intCount; intIndex++) {
      if (0 == intIndex) {
        listRow.add(getTitleRowWidget(listKey, listDetail[intIndex]));
      } else {
        listRow.add(getContentRowWidget(
            intIndex, listKey, listDetail[0], listDetail[intIndex]));
      }
    }

    return Column(
      children: listRow,
    );
  }

  ///顶部标题行
  Widget getTitleRowWidget(List listKey, List<String> listTitle) {
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
            children: getSymbolList(listKey, listTitle, listTitle),
          ),
        ),
      ),
    );
  }

  ///内容行
  Widget getContentRowWidget(int intIndex, List listKey, List<String> listTitle,
      List<String> listContent) {
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
            children: getSymbolList(listKey, listTitle, listContent),
          ),
        ),
      ),
    );
  }

  List<Widget> getSymbolList(
      final listKey, final listTitle, final listContent) {
    List<Widget> result = [];
    for (int nColumn = 0; nColumn < listContent.length; nColumn++) {
      int weight = listTitle[nColumn].length;
      Widget widgetItem = getSymbolWidget(
        listContent[nColumn],
        weight,
        getColor(listKey[nColumn]),
      );
      result.add(widgetItem);
    }
    return result;
  }

  Color getColor(String title) {
    Color colorResult = Colors.black;
    switch (title) {
      case '伏月':
        colorResult = Color(0xff176ADA);
        break;
      case '伏日':
        colorResult = Color(0xffF64B5E);
        break;
      case '伏卦':
        colorResult = Color.fromRGBO(77, 0, 178, 1);
        break;
      case '事情':
        break;
      case '六神':
        break;
      case '六爻冲合':
        break;
      case '本月':
        colorResult = Color(0xff176ADA);
        break;
      case '本日':
        colorResult = Color(0xffF64B5E);
        break;
      case '本卦':
        colorResult = Color.fromRGBO(77, 0, 178, 1);
        break;
      case '世应':
        break;
      case '进化':
        break;
      case '变卦':
        colorResult = Color.fromRGBO(77, 0, 178, 1);
        break;
      case '变月':
        colorResult = Color(0xff176ADA);
        break;
      case '变日':
        colorResult = Color(0xffF64B5E);
        break;
    }

    return colorResult;
  }

  Widget getSymbolWidget(String stringItem, int weight, Color colorItem) {
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
                style: TextStyle(fontSize: 10, color: colorItem),
              )
            ],
          ),
        ),
      ),
    );
  }
}
