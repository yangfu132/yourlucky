import 'package:flutter/material.dart';

class SAUBaseRoute extends StatefulWidget {
  const SAUBaseRoute({super.key, this.title});
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
    return const Text('Waiting');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('示例'),
      ),
      body: _buildBody(),
    );
  }
}
