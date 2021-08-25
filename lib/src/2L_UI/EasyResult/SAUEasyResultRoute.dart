import 'package:flutter/material.dart';
import 'package:yourlucky/src/3L_Business/EasyDetail/SABEasyDetailModel.dart';

import '../../3L_Business/EasyResult/SABEasyResultModel.dart';

///功能：分析推断
class SAUEasyResultRoute extends StatefulWidget {
  SAUEasyResultRoute(this.inputDetailModel);
  final SABEasyDetailModel inputDetailModel;
  final SABEasyResultModel resultModel = SABEasyResultModel();
  @override
  _SAUEasyResultState createState() {
    return _SAUEasyResultState();
  }
}

class _SAUEasyResultState extends State<SAUEasyResultRoute> {
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
          itemCount: widget.resultModel.resultList.length * 2,
          //itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            int dataIndex = index ~/ 2;
            int kv = index % 2;
            Map value = widget.resultModel.resultList[dataIndex];
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
