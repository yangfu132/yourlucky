import 'package:flutter/material.dart';
import 'package:yourlucky/src/1L_Context/SACContext.dart';

import '../../3L_Business/EasyBasic/SABEasyDigitModel.dart';
import '../../3L_Business/EasyExpert/ExpertResult/SABEasyExpertResultBusiness.dart';
import '../EasyDetail/SAUEasyDetailRoute.dart';

class SAUEasyExpertResultRoute extends StatefulWidget {
  SAUEasyExpertResultRoute(this._inputEasyModel) {
    this.resultBusiness.configResultModel(this._inputEasyModel);
  }
  final SABEasyDigitModel _inputEasyModel;
  final SABEasyExpertResultBusiness resultBusiness =
      SABEasyExpertResultBusiness();
  @override
  _SAUEasyExpertResultRoute createState() {
    return _SAUEasyExpertResultRoute();
  }
}

class _SAUEasyExpertResultRoute extends State<SAUEasyExpertResultRoute> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SAUEasyDetailRoute(widget._inputEasyModel);
              }));
            },
            child: Text('详细'),
            style: SACContext.textButtonStyle(),
          )
        ],
      ),
      body: ListView.builder(
          itemCount: widget.resultBusiness.expertModel().resultList.length * 2,
          //itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            int dataIndex = index ~/ 2;
            int kv = index % 2;
            Map value =
                widget.resultBusiness.expertModel().resultList[dataIndex];
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
