import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_navigator.dart';
import 'package:your_lucky/src/A_Context/sac_route_url.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/ListCell/sau_list_cell.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/ListCell/sau_list_cell_model.dart';
import 'package:your_lucky/src/B_UI/User/History/sau_edit_list_item.dart';
import 'package:your_lucky/src/B_UI/User/History/sau_history_list_route_store.dart';
import 'package:your_lucky/src/D_Business/DigitModel/sab_easy_digit_model.dart';
import 'package:your_lucky/src/D_Business/User/sab_login_business.dart';

class SAUHistoryListRoute extends StatefulWidget {
  SAUHistoryListRoute({super.key, this.title});
  final String? title;
  final SAUHistoryListRouteStore store = SAUHistoryListRouteStore();
  @override
  SAUHistoryListRouteState createState() {
    return SAUHistoryListRouteState();
  }
}

class SAUHistoryListRouteState extends State<SAUHistoryListRoute> {
  List<GlobalKey<SAUEditListItemState>> listKey = [];
  int positionNow = 0;
  @override
  void initState() {
    super.initState();
    widget.store.loadData(() {
      setState(() {});
    });
  }

  Widget _buildBody(BuildContext context) {
    bool isLogged = SACContext.login().isLogged();
    if (isLogged) {
      if (widget.store.historyData.isNotEmpty) {
        listKey = setEditListItemKey(widget.store.historyData.length);
        return ListView.builder(
            itemCount: widget.store.historyData.length,
            //itemExtent: 50.0, //强制高度为50.0
            itemBuilder: (BuildContext context, int index) {
              SABEasyDigitModel model = widget.store.historyData[index];
              return listCell(context,model);
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
    } else {
      return ListView.builder(
          itemCount: 1,
          //itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            return const ListTile(
              title: Text('请先登录再查看数据'),
              onTap: null,
            );
          });
    }
  }

  Widget listCell(BuildContext context, SABEasyDigitModel model) {
    SAUListCellModel cellModel = SAUListCellModel.fromEasyDigitModel(model);
    return SAUListCell(
      model: cellModel,
      onTap: (value) => {
        widget.store.onCellClicked(context, model)
      },
      buttonsClick: (value) {
        widget.store.onButtonClicked(context,positionNow,model,value, () {
          listKey.removeAt(positionNow);
          setState(() {});
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backIconButton(context),
        title: const Text('历史'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              resultAction(context);
            },
            style: SACContext.textButtonStyle(),
            child: resultActionTitle(),
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget resultActionTitle() {
    final SABLogInBusiness business = SACContext.login();
    if (business.isLogged()) {
      return const Text('已登录');
    } else {
      return const Text('请登录');
    }
  }


  void resultAction(BuildContext context) {
    SACNavigator.pushNamed(
        context,
        SACRouteUrl.logIn,
        null
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
