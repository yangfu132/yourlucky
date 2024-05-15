import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/B_UI/Common/Route/sau_textfield_route.dart';
import 'package:your_lucky/src/B_UI/Common/Route/sau_textfield_route_model.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_diagrams_detail_model.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_easy_detail_model.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_row_detail_model.dart';

///功能：一般性推断结果
class SAUSubDetailRoute extends StatefulWidget {
  SAUSubDetailRoute(this.inputDetailModel, this.intIndex);
  final SABEasyDetailModel inputDetailModel;
  final int intIndex;
  late final SABDiagramsDetailModel resultModel = SABDiagramsDetailModel();
  @override
  _SAUEasyResultState createState() {
    return _SAUEasyResultState();
  }
}

class _SAUEasyResultState extends State<SAUSubDetailRoute> {
  EasyTypeEnum currentEasyType = EasyTypeEnum.from;
  @override
  void initState() {
    super.initState();
  }

  Widget resultActionTitle() {
    if (0 == widget.intIndex) {
      return const Text('备注');
    } else {
      return const Text('切换');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(resultTitle()),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              resultAction();
            },
            child: resultActionTitle(),
            style: SACContext.textButtonStyle(),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: resultList().length * 2,
          //itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            int dataIndex = index ~/ 2;
            int kv = index % 2;
            Map value = resultList()[dataIndex];
            if (kv > 0)
              return ListTile(title: Text(value['value']));
            else
              return Container(
                //color: Colors.grey,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
                child: ListTile(title: Text(value['key'])),
              );
            //return ListTile(title: Text(value['key']));
          }),
    );
  }

  List<Map> resultList() {
    if (0 == widget.intIndex) {
      return widget.inputDetailModel.diagramsDetailModel.resultList;
    } else {
      SABRowDetailModel rowModel =
          widget.inputDetailModel.rowModelAtRow(widget.intIndex - 1);
      return rowModel.resultList(currentEasyType);
    }
  }

  String resultTitle() {
    if (0 == widget.intIndex) {
      return widget.inputDetailModel.digitModel().strStrategy;
    } else {
      SABRowDetailModel rowModel =
          widget.inputDetailModel.rowModelAtRow(widget.intIndex - 1);
      String result = 'type：';
      switch (currentEasyType) {
        case EasyTypeEnum.from:
          result = '本：';
          break;
        case EasyTypeEnum.to:
          result = '变：';
          break;
        case EasyTypeEnum.hide:
          result = '伏：';
          break;
        default:
          break;
      }
      return result + rowModel.getSymbolName(currentEasyType);
    }
  }

  void resultAction() {
    if (0 == widget.intIndex) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        SAUTextFieldRouteModel model = SAUTextFieldRouteModel(
          stringTitle: "修改目的",
          stringValue: widget.inputDetailModel.digitModel().strEasyGoal,
          stringPlaceholder: "请输入",
        );
        return SAUTextFieldRoute(
          model: model,
          onSave: (SAUTextFieldRouteModel model) {
            widget.inputDetailModel.digitModel().strEasyGoal =
                model.stringValue;
            SACContext.easyStore().save(widget.inputDetailModel.digitModel());
            Navigator.pop(context);
          },
        );
      }));
    } else {
      SABRowDetailModel rowModel =
          widget.inputDetailModel.rowModelAtRow(widget.intIndex - 1);
      currentEasyType = rowModel.getNextEasyType(currentEasyType);
      setState(() {});
    }
  }
}
