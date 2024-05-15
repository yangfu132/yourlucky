import 'package:flutter/material.dart';

class SAUAboutRoute extends StatefulWidget {
  SAUAboutRoute({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  SAUAboutRouteState createState() {
    return SAUAboutRouteState();
  }
}

class SAUAboutRouteState extends State<SAUAboutRoute> {
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
        title: Text('关于'),
      ),
      body: _buildBody(),
    );
  }
}
