import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/B_UI/Common/Route/sau_textfield_route.dart';
import 'package:your_lucky/src/B_UI/Common/Route/sau_textfield_route_model.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/ListCell/sau_list_cell.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/ListCell/sau_list_cell_model.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/sau_alert_view.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/sau_toast_widget.dart';
import 'package:your_lucky/src/B_UI/EasyStrategy/sau_strategy_result_route.dart';
import 'package:your_lucky/src/B_UI/User/History/ActionList/sau_easy_action_list_route_store.dart';
import 'package:your_lucky/src/B_UI/User/History/sau_edit_list_item.dart';
import 'package:your_lucky/src/B_UI/User/History/sau_history_list_route_store.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_easy_detail_business.dart';
import 'package:your_lucky/src/D_Business/DigitModel/sab_easy_digit_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_action_model.dart';

class SAUEasyActionListRoute extends StatefulWidget {
  const SAUEasyActionListRoute({super.key, required this.store});
  final SAUEasyActionListRouteStore store;
  @override
  SAUEasyActionListRouteState createState() {
    return SAUEasyActionListRouteState();
  }
}

class SAUEasyActionListRouteState extends State<SAUEasyActionListRoute> {
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
        title: Text(widget.store.routeTitle),
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
