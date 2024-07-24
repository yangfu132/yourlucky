import 'package:flutter/material.dart';
import 'package:your_lucky/src/D_Business/BasicEasy/sab_easy_text_business.dart';
import 'package:your_lucky/src/E_Service/sas_text_file_service.dart';

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
  SABEasyTextBusiness business = SABEasyTextBusiness();
  late ScrollController scrollController;
  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
    business.getEasyText('第一卦', '第二卦', (content) {
      this.content = content;
      setState(() {
      });
    });
  }

  Widget _buildBody() {
    return Expanded(
      child: SingleChildScrollView(
        controller: scrollController,
          child:Text(content),
      ),
    );
    //return Text(content);
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
