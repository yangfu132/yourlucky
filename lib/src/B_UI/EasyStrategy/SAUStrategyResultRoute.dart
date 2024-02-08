import 'package:flutter/material.dart';
import 'package:yourlucky/src/A_Context/SACContext.dart';
import 'package:yourlucky/src/B_UI/Common/Route/SAUTextFieldRoute.dart';
import 'package:yourlucky/src/B_UI/Common/Route/SAUTextFieldRouteModel.dart';
import 'package:yourlucky/src/B_UI/Common/Widget/Button/SAUBottomButtonBar.dart';
import 'package:yourlucky/src/B_UI/Common/Widget/Button/SAUBottomButtonBarModel.dart';
import 'package:yourlucky/src/B_UI/Common/Widget/Button/SAUButtonModel.dart';
import 'package:yourlucky/src/C_ViewModel/EasyDetail/SABEasyDetailModel.dart';
import 'package:yourlucky/src/C_ViewModel/StrategyResult/SABEasyStrategyResultBusiness.dart';

import '../EasyDetail/SAUEasyDetailRoute.dart';

///功能：显示策略推断结果
class SAUStrategyResultRoute extends StatefulWidget {
  SAUStrategyResultRoute(this.inputDetail) {
    resultBusiness = SABEasyStrategyResultBusiness(
      inputDetail: inputDetail,
      strategy: SACContext.expertCategory().stringStrategy,
    );
  }
  final SABEasyDetailModel inputDetail;
  late final SABEasyStrategyResultBusiness resultBusiness;
  @override
  _SAUStrategyResultRoute createState() {
    return _SAUStrategyResultRoute();
  }
}

class _SAUStrategyResultRoute extends State<SAUStrategyResultRoute> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SACContext.expertCategory().stringStrategy),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SAUEasyDetailRoute(widget.inputDetail);
              }));
            },
            child: Text('详细'),
            style: SACContext.textButtonStyle(),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _buildList()),
          SAUBottomButtonBar(
              model: buttonModel(),
              onTap: (SAUButtonModel itemModel) {
                if ("save" == itemModel.code) {
                  SACContext.easyStore().save(widget.inputDetail.digitModel());
                }
                if ("goal" == itemModel.code) {
                  onGoalTapped();
                }
                if ("annotate" == itemModel.code) {
                  onAnnotateTapped();
                }
              }),
        ],
      ),
    );
  }

  void onGoalTapped() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      SAUTextFieldRouteModel model = SAUTextFieldRouteModel(
        stringTitle: "修改目的",
        stringValue: widget.inputDetail.digitModel().strEasyGoal,
        stringPlaceholder: "请输入",
      );
      return SAUTextFieldRoute(
        model: model,
        onSave: (SAUTextFieldRouteModel model) {
          widget.inputDetail.digitModel().strEasyGoal = model.stringValue;
          SACContext.easyStore().save(widget.inputDetail.digitModel());
          Navigator.pop(context);
        },
      );
    }));
  }

  void onAnnotateTapped() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      SAUTextFieldRouteModel model = SAUTextFieldRouteModel(
        stringTitle: "修改批注",
        stringValue: widget.inputDetail.digitModel().strAnnotate,
        stringPlaceholder: "请输入",
      );
      return SAUTextFieldRoute(
        model: model,
        onSave: (SAUTextFieldRouteModel model) {
          widget.inputDetail.digitModel().strAnnotate = model.stringValue;
          SACContext.easyStore().save(widget.inputDetail.digitModel());
          Navigator.pop(context);
        },
      );
    }));
  }

  SAUBottomButtonBarModel buttonModel() {
    SAUButtonModel save = SAUButtonModel(title: "保存", code: "save");
    SAUButtonModel goal = SAUButtonModel(title: "目的", code: "goal");
    SAUButtonModel annotate = SAUButtonModel(title: "批注", code: "annotate");
    final SAUBottomButtonBarModel buttonModel =
        SAUBottomButtonBarModel(itemList: [save, goal, annotate]);
    return buttonModel;
  }

  Widget _buildList() {
    return ListView.builder(
        itemCount: widget.resultBusiness.resultModel().resultList().length * 2,
        //itemExtent: 50.0, //强制高度为50.0
        itemBuilder: (BuildContext context, int index) {
          int dataIndex = index ~/ 2;
          int kv = index % 2;
          Map value =
              widget.resultBusiness.resultModel().resultList()[dataIndex];
          if (kv > 0)
            return ListTile(title: Text(value['value']));
          else
            return Container(
              //color: Colors.grey,
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: ListTile(
                title: Text(value['key']),
              ),
            );
          //return ListTile(title: Text(value['key']));
        });
  }
}
