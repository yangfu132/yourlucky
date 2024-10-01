import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Text/sau_text_route_store.dart';

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
    return SingleChildScrollView(
      controller: scrollController,
      child:Text(content),
    );
    //return Text(content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backIconButton(context),
        title: Text(widget.store.titleModel().title),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              widget.store.titleModel().tapTitle(context,(){
                setState(() {});
              });
            },
            style: SACContext.textButtonStyle(),
            child: Text(widget.store.titleModel().actionTitle),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  IconButton backIconButton(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        });
  }
}
