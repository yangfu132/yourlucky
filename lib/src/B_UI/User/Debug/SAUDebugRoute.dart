import 'package:flutter/material.dart';

class SAUDebugRoute extends StatefulWidget {
  SAUDebugRoute({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  SAUDebugRouteState createState() {
    return SAUDebugRouteState();
  }
}

class SAUDebugRouteState extends State<SAUDebugRoute> {
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
        title: Text('调试'),
      ),
      body: _buildBody(),
    );
  }
}
