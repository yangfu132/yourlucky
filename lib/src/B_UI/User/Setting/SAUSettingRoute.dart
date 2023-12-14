import 'package:flutter/material.dart';

class SAUSettingRoute extends StatefulWidget {
  SAUSettingRoute({Key? key, this.title}) : super(key: key);
  final String? title;
  bool switchValue = false;
  @override
  SAUSettingRouteState createState() {
    return SAUSettingRouteState();
  }
}

class SAUSettingRouteState extends State<SAUSettingRoute> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildBody() {
    // return Text('Waiting');
    return ListView.builder(itemCount: 10,itemBuilder: (BuildContext context, int index){
      return _rowWidget(widget.switchValue);
    },);
  }

  Widget _rowWidget (bool switchValue){
    return Container(
      child:
        Row(
          children: [
            Text('Waiting,WaitingWaitingWaiting'),
            Switch(
              value: switchValue,
              onChanged: (value){
                widget.switchValue = !switchValue;
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
