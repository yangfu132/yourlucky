import 'package:flutter/material.dart';
import 'package:yourlucky/src/A_Context/SACContext.dart';
import 'package:yourlucky/src/D_Business/User/SABSettingModel.dart';

class SAUSettingRoute extends StatefulWidget {
  SAUSettingRoute({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  SAUSettingRouteState createState() {
    return SAUSettingRouteState();
  }
}

class SAUSettingRouteState extends State<SAUSettingRoute> {
  List<SABSettingModel> settingList = [];
  @override
  void initState() {
    super.initState();
    SACContext.setting().load((dataList) {
      settingList = dataList;
      setState(() {});
    });
  }

  Widget _buildBody() {
    // return Text('Waiting');
    return ListView.builder(itemCount: 10,itemBuilder: (BuildContext context, int index){
      SABSettingModel settingModel = settingList[index];
      return _rowWidget(settingModel);
    },);
  }

  Widget _rowWidget (SABSettingModel settingModel){
    return Container(
      child:
        Row(
          children: [
            Text(settingModel.settingTitle),
            Switch(
              value: settingModel.settingValue,
              onChanged: (value){
                  settingModel.settingValue = !value;
                  SACContext.setting().save(settingModel);
                  setState(() {
                });
              }
            ),
          ],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: _buildBody(),
    );
  }
}
