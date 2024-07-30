import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/B_UI/Backup/sau_backup_route_store.dart';

class SAUBaseRoute extends StatefulWidget {
  const SAUBaseRoute({super.key, this.title, required this.store});
  final String? title;
  final SAUBackupRouteStore store;
  @override
  SAUBaseRouteState createState() {
    return SAUBaseRouteState();
  }
}
class SAUBaseRouteState extends State<SAUBaseRoute> {

  @override
  void initState() {
    super.initState();
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

  Widget _buildBody() {
    return const Text('空');
  }
}
