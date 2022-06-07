import 'package:flutter/material.dart';

class SAUSettingRoute extends StatefulWidget {
  SAUSettingRoute({Key? key, this.title}) : super(key: key);
  final String? title;
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
    return Text('Waiting');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('反馈'),
      ),
      body: _buildBody(),
    );
  }
}
