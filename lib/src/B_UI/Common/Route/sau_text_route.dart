import 'package:flutter/material.dart';
import 'package:your_lucky/src/E_Service/sas_file_service.dart';

class SAUTextRoute extends StatefulWidget {
  const SAUTextRoute({super.key, this.title});
  final String? title;
  @override
  SAUTextRouteState createState() {
    return SAUTextRouteState();
  }
}

class SAUTextRouteState extends State<SAUTextRoute> {
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
