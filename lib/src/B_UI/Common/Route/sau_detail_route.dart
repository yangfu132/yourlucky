import 'package:flutter/material.dart';
import 'package:your_lucky/src/E_Service/sas_file_service.dart';

class SAUDetailRoute extends StatefulWidget {
  SAUDetailRoute({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  SAUDetailRouteState createState() {
    return SAUDetailRouteState();
  }
}

class SAUDetailRouteState extends State<SAUDetailRoute> {
  var content = 'loading';

  @override
  void initState() {
    super.initState();
    SASFileService.readFile((content) {
      this.content = content;
      setState(() {

      });
    });
  }

  Widget _buildBody() {
    return Text(content);
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
