import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_base_info_detail_route_store.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_detail_route.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_detail_route_store.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_empty_detail_route_store.dart';
import 'package:your_lucky/src/B_UI/Common/Route/sau_text_route.dart';
import 'package:your_lucky/src/B_UI/Common/Route/sau_textfield_route.dart';
import 'package:your_lucky/src/B_UI/Common/Route/sau_textfield_route_model.dart';
import 'package:your_lucky/src/B_UI/Common/Route/List/sau_list_route.dart';
import 'package:your_lucky/src/B_UI/User/History/ActionList/sau_easy_action_list_route_store.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_easy_detail_model.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_row_detail_model.dart';

///功能：一般性推断结果
class SAUSubDetailRoute extends StatefulWidget {
  const SAUSubDetailRoute(this.inputDetailModel, this.uiRow, {super.key});
  final SABEasyDetailModel inputDetailModel;
  final int uiRow;
  @override
  State<SAUSubDetailRoute> createState() {
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
    if (0 == widget.uiRow) {
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
            style: SACContext.textButtonStyle(),
            child: resultActionTitle(),
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
            if (kv > 0) {
              return ListTile(
                title: Text(value['value']),
                onTap: (){
                  onCellClicked(value);
              },);
            } else {
              return Container(
                //color: Colors.grey,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
                child: ListTile(
                    title: Text(value['key']),
                    onTap: (){
                      onCellClicked(value);
                    },
                ),
              );
            }
            //return ListTile(title: Text(value['key']));
          }),
    );
  }

  void onCellClicked(Map value){
    if ('用神' == value['key']) {
      onUsefulDeityClicked();
    } else if ('空白' == value['key']) {
      onActionListTapped(context);
    }  else if ('计算信息' == value['key']) {
      onActionListTapped(context);
    } else if ('日将' == value['key']) {
      int uiRow = widget.inputDetailModel.getUsefulDeity().symbolRow + 1;
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        final store = SAUDetailDetailRouteStore(
            inputDetailModel:widget.inputDetailModel,
            uiRow: uiRow,
            easyType: EasyTypeEnum.from
        );
        return SAUDetailRoute(store:store);
      }));
    }
  }

  void onTextClicked(){
    int uiRow = widget.inputDetailModel.getUsefulDeity().symbolRow + 1;
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SAUTextRoute();
    }));
  }

  void onUsefulDeityClicked(){
    int uiRow = widget.inputDetailModel.getUsefulDeity().symbolRow + 1;
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      final store = SAUBaseInfoDetailRouteStore(
          inputDetailModel:widget.inputDetailModel,
          uiRow: uiRow,
          easyType: EasyTypeEnum.from
      );
      return SAUDetailRoute(store:store);
    }));
  }

  void onActionListTapped(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      SAUActionListRouteStore store = SAUActionListRouteStore(
        inputDetailModel:widget.inputDetailModel,
        nRow:SACContext.uiRowToSymbolRow(widget.uiRow),
        easyType: EasyTypeEnum.from,
      );
      return SAUListRoute(store:store);
    }));
  }

  List<Map> resultList() {
    if (0 == widget.uiRow) {
      return widget.inputDetailModel.diagramsDetailModel.resultList;
    } else if (globalRowDay == widget.uiRow) {
      return widget.inputDetailModel.dayModel.resultList();
    } else if (globalRowMonth == widget.uiRow) {
      return widget.inputDetailModel.monthModel.resultList();
    } else {
      SABRowDetailModel rowModel =
          widget.inputDetailModel.rowModelAtRow(widget.uiRow - 1);
      return rowModel.resultList(currentEasyType);
    }
  }

  String resultTitle() {
    if (0 == widget.uiRow) {
      return widget.inputDetailModel.digitModel().strStrategy;
    } else if (globalRowDay == widget.uiRow) {
      return widget.inputDetailModel.dayModel.strSymbolName;
    } else if (globalRowMonth == widget.uiRow) {
      return widget.inputDetailModel.monthModel.strSymbolName;
    } else {
      SABRowDetailModel rowModel =
          widget.inputDetailModel.rowModelAtRow(widget.uiRow - 1);
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
    if (0 == widget.uiRow) {
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
          widget.inputDetailModel.rowModelAtRow(widget.uiRow - 1);
      currentEasyType = rowModel.getNextEasyType(currentEasyType);
      setState(() {});
    }
  }
}
