import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/B_UI/Common/Route/sau_textfield_route.dart';
import 'package:your_lucky/src/B_UI/Common/Route/sau_textfield_route_model.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_easy_detail_model.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_row_detail_model.dart';

import 'sau_detail_route_model.dart';

class SAUDetailRouteStoreModel {
  SAUDetailRouteStoreModel({
    required this.inputDetailModel,
    required this.intIndex,
    required this.easyType});

  final SABEasyDetailModel inputDetailModel;
  final int intIndex;
  EasyTypeEnum easyType;
  SAUDetailRouteModel data = loadingDetailRouteModel('');

  SAUDetailRouteModel requestData() {

    SAUDetailTitleModel titleModel = SAUDetailTitleModel(title:resultTitle(),
        actionTitle: resultActionTitle(),tapTitle:resultAction);
    data = SAUDetailRouteModel(titleModel:titleModel,
        cardList:[
          baseInfoCard(),
          healthInfoCard(),
          debugInfoCard()
        ],
        buttonRoles:[]);
    return data;
  }


  String resultTitle() {
    if (0 == intIndex) {
      return inputDetailModel.digitModel().strStrategy;
    } else if (globalRowDay == intIndex) {
      return inputDetailModel.dayModel.strSymbolName;
    } else if (globalRowMonth == intIndex) {
      return inputDetailModel.monthModel.strSymbolName;
    } else {
      SABRowDetailModel rowModel =
      inputDetailModel.rowModelAtRow(intIndex - 1);
      String result = 'type：';
      switch (easyType) {
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
      return result + rowModel.getSymbolName(easyType);
    }
  }

  void resultAction(BuildContext context, VoidCallback refreshAction) {
    if (0 == intIndex) {
      gotoTextField(context);
    } else {
      SABRowDetailModel rowModel =
      inputDetailModel.rowModelAtRow(intIndex - 1);
      easyType = rowModel.getNextEasyType(easyType);
      refreshAction();
    }
  }

  String resultActionTitle() {
    if (0 == intIndex) {
      return '备注';
    } else {
      return '切换';
    }
  }

  SAUDetailCardModel baseInfoCard () {
    final List<Map> resultList;
    if (0 == intIndex) {
      resultList = inputDetailModel.diagramsDetailModel.resultList;
    } else if (globalRowDay == intIndex) {
      resultList = inputDetailModel.dayModel.resultList();
    } else if (globalRowMonth == intIndex) {
      resultList =  inputDetailModel.monthModel.resultList();
    } else {
      SABRowDetailModel rowModel =
      inputDetailModel.rowModelAtRow(intIndex - 1);
      resultList =  rowModel.resultList(easyType);
    }

    SAUDetailCardModel cardModel = SAUDetailCardModel(title: "基本信息",
        resultList: resultList,
        tapTitle:gotoBaseInfo
    );
    return cardModel;
  }

  SAUDetailCardModel healthInfoCard () {
    return todoCard("Health信息");
  }

  SAUDetailCardModel debugInfoCard () {
    return todoCard("debug信息");
  }


  void gotoBaseInfo(BuildContext context,VoidCallback refreshAction) {
  }

  void gotoTextField(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      SAUTextFieldRouteModel model = SAUTextFieldRouteModel(
        stringTitle: "修改目的",
        stringValue: inputDetailModel.digitModel().strEasyGoal,
        stringPlaceholder: "请输入",
      );
      return SAUTextFieldRoute(
        model: model,
        onSave: (SAUTextFieldRouteModel model) {
          inputDetailModel.digitModel().strEasyGoal =
              model.stringValue;
          SACContext.easyStore().save(inputDetailModel.digitModel());
          Navigator.pop(context);
        },
      );
    }));
  }

  void tapButton(String code) async {

  }
}
