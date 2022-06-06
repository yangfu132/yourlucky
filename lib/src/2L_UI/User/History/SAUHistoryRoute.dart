import 'package:flutter/material.dart';
import 'package:yourlucky/src/1L_Context/SACContext.dart';
import 'package:yourlucky/src/3L_Business/DigitModel/SABEasyDigitModel.dart';

class SAUHistoryRoute extends StatefulWidget {
  SAUHistoryRoute({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  SAUHistoryRouteState createState() {
    return SAUHistoryRouteState();
  }
}

class SAUHistoryRouteState extends State<SAUHistoryRoute> {
  List<SABEasyDigitModel> historyData = [];
  @override
  void initState() {
    super.initState();
    SACContext.easyStore().load((dataList) {
      historyData = dataList;
      setState(() {});
    });
  }

  Widget _buildBody() {
    if (historyData.length > 0) {
      return ListView.builder(
          itemCount: historyData.length,
          //itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            SABEasyDigitModel model = historyData[index];
            return Container(
              //color: Colors.grey,
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: ListTile(
                title: Text(model.stringDescribe),
                onTap: null,
              ),
            );
          });
    } else {
      return ListView.builder(
          itemCount: 1,
          //itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            return Container(
              //color: Colors.grey,
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: ListTile(
                title: Text('waiting'),
                onTap: null,
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('历史'),
      ),
      body: _buildBody(),
    );
  }
}
