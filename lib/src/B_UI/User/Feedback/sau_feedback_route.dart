import 'package:flutter/material.dart';

class SAUFeedbackRoute extends StatefulWidget {
  const SAUFeedbackRoute({super.key, this.title});
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
    return const Text('Waiting');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('反馈'),
      ),
      body: _buildBody(),
    );
  }
}
