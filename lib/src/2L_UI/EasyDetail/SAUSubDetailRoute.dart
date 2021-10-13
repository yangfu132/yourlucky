import 'package:flutter/material.dart';
import 'package:yourlucky/src/3L_Business/EasyDetail/SABEasyDetailModel.dart';

import '../../3L_Business/EasyDetail/SABDiagramsDetailModel.dart';

///功能：一般性推断结果
class SAUSubDetailRoute extends StatefulWidget {
  SAUSubDetailRoute(this.inputDetailModel, this.intIndex);
  final SABEasyDetailModel inputDetailModel;
  final int intIndex;
  late final SABDiagramsDetailModel resultModel = SABDiagramsDetailModel();
  @override
  _SAUEasyResultState createState() {
    return _SAUEasyResultState();
  }

  List<Map> resultList() {
    if (0 == intIndex) {
      return inputDetailModel.diagramsDetailModel.resultList;
    } else {
      return inputDetailModel.rowModelAtRow(intIndex - 1).resultList;
    }
  }
}

class _SAUEasyResultState extends State<SAUSubDetailRoute> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.inputDetailModel.wordsModel().stringFormatTime),
      ),
      body: ListView.builder(
          itemCount: widget.resultList().length * 2,
          //itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            int dataIndex = index ~/ 2;
            int kv = index % 2;
            Map value = widget.resultList()[dataIndex];
            if (kv > 0)
              return ListTile(title: Text(value['value']));
            else
              return Container(
                //color: Colors.grey,
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: ListTile(title: Text(value['key'])),
              );
            //return ListTile(title: Text(value['key']));
          }),
    );
  }
}
