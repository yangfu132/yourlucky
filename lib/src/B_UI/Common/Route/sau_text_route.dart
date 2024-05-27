import 'package:flutter/material.dart';
import 'package:your_lucky/src/E_Service/sas_file_service.dart';

class SAUDetailRoute extends StatefulWidget {
  const SAUDetailRoute({super.key, this.title});
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
        title: const Text('示例'),
      ),
      body: _buildBody(),
    );
  }
}
