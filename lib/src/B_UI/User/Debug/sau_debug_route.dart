import 'package:flutter/material.dart';

class SAUDebugRoute extends StatefulWidget {
  const SAUDebugRoute({super.key, this.title});
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
    return const Text('Waiting');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('调试'),
      ),
      body: _buildBody(),
    );
  }
}
