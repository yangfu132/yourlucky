import 'package:flutter/material.dart';

import 'sau_home_body.dart';

class SAUHomeRoute extends StatefulWidget {
  const SAUHomeRoute({super.key, this.title});
  final String? title;
  @override
  SAUHomeRouteState createState() {
    return SAUHomeRouteState();
  }
}

class SAUHomeRouteState extends State<SAUHomeRoute> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: SAUHomeBody(),
    );
  }
}
