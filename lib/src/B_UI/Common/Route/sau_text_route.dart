import 'package:flutter/material.dart';
import 'package:your_lucky/src/B_UI/Common/Route/sau_text_route_store.dart';

class SAUTextRoute extends StatefulWidget {
  const SAUTextRoute({super.key, this.title, required this.store});
  final String? title;
  final SAUTextRouteStore store;
  @override
  SAUTextRouteState createState() {
    return SAUTextRouteState();
  }
}

class SAUTextRouteState extends State<SAUTextRoute> {
  var content = 'loading';
  late ScrollController scrollController;
  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
    widget.store.loadData((content) {
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
