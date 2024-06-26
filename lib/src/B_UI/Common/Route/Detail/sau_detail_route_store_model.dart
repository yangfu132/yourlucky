import 'package:your_lucky/src/A_Context/sac_global.dart';
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
  final EasyTypeEnum easyType;
  SAUDetailRouteModel? data;

  SAUDetailRouteModel? requestData() {
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
    data ??= SAUDetailRouteModel(title:resultTitle(),
        resultList:resultList,
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

  void gotoOperationHistory() {

  }

  void gotoVehicleInfo() {
  }

  void callMobilePhone(String phone) {
  }

  void gotoOutInfo() {
  }

  void gotoInInfo() {
  }

  void tapButton(String code) async {

  }
}
