﻿import 'package:flutter/material.dart';
import 'package:yourlucky/src/1L_Context/SACContext.dart';
import 'package:yourlucky/src/3L_Business/EasyDetail/SABEasyDetailModel.dart';
import 'package:yourlucky/src/3L_Business/EasyStrategyResult/StrategyResult/SABEasyStrategyResultBusiness.dart';

import '../EasyDetail/SAUEasyDetailRoute.dart';

///功能：显示策略推断结果
class SAUStrategyResultRoute extends StatefulWidget {
  SAUStrategyResultRoute(this.inputDetail) {
    resultBusiness = SABEasyStrategyResultBusiness(
      inputDetail: inputDetail,
      strategy: SACContext.expertCategory().stringStrategy,
    );
  }
  final SABEasyDetailModel inputDetail;
  late final SABEasyStrategyResultBusiness resultBusiness;
  @override
  _SAUStrategyResultRoute createState() {
    return _SAUStrategyResultRoute();
  }
}

class _SAUStrategyResultRoute extends State<SAUStrategyResultRoute> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SACContext.expertCategory().stringStrategy),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SAUEasyDetailRoute(widget.inputDetail);
              }));
            },
            child: Text('详细'),
            style: SACContext.textButtonStyle(),
          )
        ],
      ),
      body: ListView.builder(
          itemCount:
              widget.resultBusiness.resultModel().resultList().length * 2,
          //itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            int dataIndex = index ~/ 2;
            int kv = index % 2;
            Map value =
                widget.resultBusiness.resultModel().resultList()[dataIndex];
            if (kv > 0)
              return ListTile(title: Text(value['value']));
            else
              return Container(
                //color: Colors.grey,
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: ListTile(
                  title: Text(value['key']),
                ),
              );
            //return ListTile(title: Text(value['key']));
          }),
    );
  }
}
