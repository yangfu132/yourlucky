import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/B_UI/Common/Route/sau_textfield_route.dart';
import 'package:your_lucky/src/B_UI/Common/Route/sau_textfield_route_model.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/ListCell/sau_list_cell.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/ListCell/sau_list_cell_model.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/sau_alert_view.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/sau_toast_widget.dart';
import 'package:your_lucky/src/B_UI/EasyStrategy/sau_strategy_result_route.dart';
import 'package:your_lucky/src/B_UI/User/History/sau_edit_list_item.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_easy_detail_business.dart';

import '../../../D_Business/Develop/sab_develop_business.dart';
import '../../../D_Business/Develop/sab_develop_model.dart';

class SAUDevelopListRoute extends StatefulWidget {
  const SAUDevelopListRoute({super.key, this.title});
  final String? title;
  @override
  SAUDevelopListRouteState createState() {
    return SAUDevelopListRouteState();
  }
}

class SAUDevelopListRouteState extends State<SAUDevelopListRoute> {
  List<SABDevelopModel> historyData = [];
  List<GlobalKey<SAUEditListItemState>> listKey = [];
  int positionNow = 0;
  @override
  void initState() {
    super.initState();
    SACContext.develop().load((dataList) {
      historyData = dataList;
      setState(() {});
    });
  }

  void onAnnotateTapped(SABDevelopModel digitModel) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      SAUTextFieldRouteModel model = SAUTextFieldRouteModel(
        stringTitle: "修改批注",
        stringValue: digitModel.strAnnotate,
        stringPlaceholder: "请输入",
      );
      return SAUTextFieldRoute(
        model: model,
        onSave: (SAUTextFieldRouteModel model) {
          digitModel.strAnnotate = model.stringValue;
          SACContext.develop().save(digitModel);
          Navigator.pop(context);
        },
      );
    }));
  }

  void _deleteHistory(SABDevelopModel model) {
    SAUAlertWidget.showTitle(context, '删除后将无法看到该条记录，请谨慎操作', [
      SAUAlertAction(title: '取消', isColorGrey: true),
      SAUAlertAction(
          title: '确定',
          isDefault: true,
          action: () {
            SAUToastWidget.show("你点击了删除 ${model.title()}");
            SACContext.develop().delete(model);
            listKey.removeAt(positionNow);
            historyData.removeAt(positionNow);
            setState(() {});
          })
    ]);
  }

  Widget _buildBody() {
    if (historyData.isNotEmpty) {
      listKey = setEditListItemKey(historyData.length);
      return ListView.builder(
          itemCount: historyData.length,
          //itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            SABDevelopModel model = historyData[index];
            return listCell(model);
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

  Widget listCell(SABDevelopModel model) {
    SAUListCellModel cellModel = SAUListCellModel.fromDevelopModel(model);
    return SAUListCell(
      model: cellModel,
      onTap: (value) => {
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   SABEasyDetailBusiness detailBusiness = SABEasyDetailBusiness(model);
        //   return SAUStrategyResultRoute(detailBusiness.outputDetailModel());
        // }))
      },
      buttonsClick: (value) {
        if ('delete' == value.code) {
          _deleteHistory(model);
        }
        if ('annotate' == value.code) {
          onAnnotateTapped(model);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backIconButton(context),
        title: const Text('开发计划'),
        actions: <Widget>[
          TextButton(
            onPressed: () {

              Navigator.push(context, MaterialPageRoute(builder: (context) {
                SAUTextFieldRouteModel model = SAUTextFieldRouteModel(
                  stringTitle: "修改目的",
                  stringValue: "",
                  stringPlaceholder: "请输入",
                );
                return SAUTextFieldRoute(
                  model: model,
                  onSave: (SAUTextFieldRouteModel model) {
                    SABDevelopModel taskModel = SACContext.develop().create();
                    taskModel.strGoal = model.stringValue;
                    SACContext.develop().save(taskModel);
                    Navigator.pop(context);
                  },
                );
              }));
            },
            style: SACContext.textButtonStyle(),
            child: const Text('新建',style: TextStyle(fontWeight: FontWeight.bold),),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  IconButton backIconButton(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        });
  }
}
