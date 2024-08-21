import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'sau_easy_result_route_store.dart';

class SAUEasyResultRoute extends StatefulWidget {
  const SAUEasyResultRoute({super.key, required this.store});
  final SAUEasyResultRouteStore store;
  @override
  SAUEasyResultRouteState createState() {
    return SAUEasyResultRouteState();
  }
}

class SAUEasyResultRouteState extends State<SAUEasyResultRoute> {
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
      child:Center(child: Text(content),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: backIconButton(context),
      //   title: Text(widget.store.titleModel().title),
      //   actions: <Widget>[
      //     TextButton(
      //       onPressed: () {
      //         widget.store.titleModel().tapTitle(context,(){
      //           setState(() {});
      //         });
      //       },
      //       style: SACContext.textButtonStyle(),
      //       child: Text(widget.store.titleModel().actionTitle),
      //     ),
      //   ],
      // ),
      appBar: AppBar(
        backgroundColor: Colors.transparent, // 设置AppBar为透明
        elevation: 0, // 去除AppBar的阴影
        automaticallyImplyLeading: false,
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

