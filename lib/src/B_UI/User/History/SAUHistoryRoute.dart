import 'package:flutter/material.dart';
import 'package:yourlucky/src/A_Context/SACContext.dart';
import 'package:yourlucky/src/B_UI/EasyStrategy/SAUStrategyResultRoute.dart';
import 'package:yourlucky/src/C_ViewModel/EasyDetail/SABEasyDetailBusiness.dart';
import 'package:yourlucky/src/D_Business/DigitModel/SABEasyDigitModel.dart';

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

  Widget _rowWidget(SABEasyDigitModel model) {
    return ListTile(
      title: Text(model.title()),
      trailing: Text(model.describe()),
      onTap: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          SABEasyDetailBusiness detailBusiness = SABEasyDetailBusiness(model);
          return SAUStrategyResultRoute(detailBusiness.outputDetailModel());
        }));
      },
    );
  }

  Widget _buildBody() {
    if (historyData.length > 0) {
      return ListView.builder(
          itemCount: historyData.length,
          //itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            SABEasyDigitModel model = historyData[index];
            int kv = index % 2;
            if (kv == 0) {
              return _rowWidget(model);
            } else {
              return Container(
                //color: Colors.grey,
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: _rowWidget(model),
              );
            }
          });
    } else {
      return ListView.builder(
          itemCount: 1,
          //itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text('waiting'),
              onTap: null,
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
