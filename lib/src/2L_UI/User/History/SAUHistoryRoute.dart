import 'package:flutter/material.dart';

class SAUHistoryRoute extends StatefulWidget {
  SAUHistoryRoute({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  SAUHistoryRouteState createState() {
    return SAUHistoryRouteState();
  }
}

class SAUHistoryRouteState extends State<SAUHistoryRoute> {
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
        title: Text('历史'),
      ),
      body: _buildBody(),
    );
  }
}
