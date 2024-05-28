import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/B_UI/EasyDetail/sau_subdetail_route.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_easy_detail_model.dart';

class SAUEasyDetailRoute extends StatefulWidget {
  const SAUEasyDetailRoute(this.inputDetailModel, {super.key});
  final SABEasyDetailModel inputDetailModel;

  @override
  State<SAUEasyDetailRoute> createState() {
    return _SAUEasyDetailRouteState();
  }
}

class _SAUEasyDetailRouteState extends State<SAUEasyDetailRoute> {
  @override
  void initState() {
    super.initState();
    //隐藏状态栏 SystemChrome.setEnabledSystemUIOverlays([]);
  }

  SABEasyDetailModel detailModel() {
    return widget.inputDetailModel;
  }

  @override
  Widget build(BuildContext context) {
    if (SACContext.simulator()) {
      return Scaffold(
        appBar: AppBar(
          title: Text(detailModel().stringDetailName),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                SACContext.easyStore().save(detailModel().digitModel());
              },
              style: SACContext.textButtonStyle(),
              child: const Text('保存'),
            ),
          ],
        ),
        body: _buildBody(),
      );
    } else {
      return RotatedBox(
        quarterTurns: 1,
        child: Scaffold(
          appBar: AppBar(
            title: Text(detailModel().stringDetailName),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  SACContext.easyStore().save(detailModel().digitModel());
                },
                style: SACContext.textButtonStyle(),
                child: const Text('保存'),
              ),
            ],
          ),
          body: _buildBody(),
        ),
      );
    }
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
          decoration: const BoxDecoration(
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
          decoration: const BoxDecoration(
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
    int listContentLength = listContent.length;
    int listTitleLength = listTitle.length;
    int listKeyLength = listKey.length;
    int weight = 1;
    String strKey = 'Error';
    for (int nColumn = 0; nColumn < listContentLength; nColumn++) {
      if (nColumn < listTitleLength) {
        weight = listTitle[nColumn].length;
      } else {
        coLog(StackTrace.current, LogTypeEnum.error, "error!");
      }

      if (nColumn < listKeyLength) {
        strKey = listContent[nColumn];
      } else {
        coLog(StackTrace.current, LogTypeEnum.error, "error!");
      }

      Widget widgetItem = getSymbolWidget(
        listContent[nColumn],
        weight,
        getColor(strKey),
      );
      result.add(widgetItem);
    }
    return result;
  }

  Color getColor(String title) {
    Color colorResult = Colors.black;
    switch (title) {
      case '伏月':
        colorResult = const Color(0xff176ADA);
        break;
      case '伏日':
        colorResult = const Color(0xffF64B5E);
        break;
      case '伏卦':
        colorResult = const Color.fromRGBO(77, 0, 178, 1);
        break;
      case '事情':
        break;
      case '六神':
        break;
      case '六爻冲合':
        break;
      case '本月':
        colorResult = const Color(0xff176ADA);
        break;
      case '本日':
        colorResult = const Color(0xffF64B5E);
        break;
      case '本卦':
        colorResult = const Color.fromRGBO(77, 0, 178, 1);
        break;
      case '世应':
        break;
      case '进化':
        break;
      case '变卦':
        colorResult = const Color.fromRGBO(77, 0, 178, 1);
        break;
      case '变月':
        colorResult = const Color(0xff176ADA);
        break;
      case '变日':
        colorResult = const Color(0xffF64B5E);
        break;
    }

    return colorResult;
  }

  Widget getSymbolWidget(String stringItem, int weight, Color colorItem) {
    return Expanded(
      flex: weight,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: double.infinity),
        child: Container(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          foregroundDecoration: const BoxDecoration(
            border: Border(
              right: BorderSide(width: 1, color:Color(0xffe5e5e5)),
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
