import 'package:flutter/material.dart';

class SAUDetailRoute extends StatefulWidget {
  SAUDetailRoute({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  SAUDetailRouteState createState() {
    return SAUDetailRouteState();
  }
}

class SAUDetailRouteState extends State<SAUDetailRoute> {
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
