import 'package:flutter/material.dart';

class SAUBaseRoute extends StatefulWidget {
  SAUBaseRoute({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  SAUBaseRouteState createState() {
    return SAUBaseRouteState();
  }
}

class SAUBaseRouteState extends State<SAUBaseRoute> {
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
        title: Text('示例'),
      ),
      body: _buildBody(),
    );
  }
}
