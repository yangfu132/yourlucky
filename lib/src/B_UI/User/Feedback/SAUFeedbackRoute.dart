import 'package:flutter/material.dart';

class SAUFeedbackRoute extends StatefulWidget {
  SAUFeedbackRoute({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  SAUFeedbackRouteState createState() {
    return SAUFeedbackRouteState();
  }
}

class SAUFeedbackRouteState extends State<SAUFeedbackRoute> {
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
