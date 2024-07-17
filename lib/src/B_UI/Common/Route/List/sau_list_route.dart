import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/B_UI/Common/Route/List/sau_list_route_store.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/ListCell/sau_list_cell.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/ListCell/sau_list_cell_model.dart';
import 'package:your_lucky/src/B_UI/User/History/sau_edit_list_item.dart';

class SAUListRoute extends StatefulWidget {
  const SAUListRoute({super.key, required this.store});
  final SAUListRouteStore store;
  @override
  SAUListRouteState createState() {
    return SAUListRouteState();
  }
}

class SAUListRouteState extends State<SAUListRoute> {
  List<GlobalKey<SAUEditListItemState>> listKey = [];
  int positionNow = 0;
  @override
  void initState() {
    super.initState();
    widget.store.loadData(() {
      setState(() {});
    });
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
      body: _buildBody(context),
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

  Widget _buildBody(BuildContext context) {
    if (widget.store.listData.isNotEmpty) {
      listKey = setEditListItemKey(widget.store.listData.length);
      return ListView.builder(
          itemCount: widget.store.listData.length,
          //itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            return listCell(context,widget.store.cellModelAtIndex(index));
          });
    } else {
      return ListView.builder(
          itemCount: 1,
          //itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            return const ListTile(
              title: Text('暂无数据，请稍后再试'),
              onTap: null,
            );
          });
    }
  }

  Widget listCell(BuildContext context,SAUListCellModel model) {
    return SAUListCell(
      model: model,
      onTap: (value) {
        widget.store.onCellTapped(context, () { });
      },
      buttonsClick: (value) {
        widget.store.onButtonClicked(value, context, () { });
      },
    );
  }
}
