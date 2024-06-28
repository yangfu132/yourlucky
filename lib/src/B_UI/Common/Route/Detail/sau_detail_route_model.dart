
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/Button/sau_button_model.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';

typedef ContextCallback = void Function(BuildContext context,VoidCallback refreshAction);
class SAUDetailTitleModel extends SABBaseModel {
  SAUDetailTitleModel({required this.title,required this.actionTitle, required this.tapTitle});
  final String title;
  final String actionTitle;
  final ContextCallback tapTitle;
}

class SAUDetailCardModel extends SABBaseModel {
  SAUDetailCardModel({required this.title,required this.resultList, required this.tapTitle});
  final List<Map> resultList;
  final String title;
  final ContextCallback tapTitle;
}

class SAUDetailRouteModel extends SABBaseModel {
  SAUDetailRouteModel({required this.titleModel,required this.cardList,required this.buttonRoles});
  final SAUDetailTitleModel titleModel;
  final List<SAUDetailCardModel> cardList;
  final List<SAUButtonModel> buttonRoles;
  SAUDetailCardModel getCardModel(int index) {
    if (index < cardList.length) {
      return cardList[index];
    } else {
      return outErrorCard(index,cardList);
    }
  }
}

SAUDetailRouteModel loadingDetailRouteModel(String title) {
  SAUDetailTitleModel titleModel = SAUDetailTitleModel(title:title,
      actionTitle: '刷新',tapTitle:(BuildContext context,VoidCallback refreshAction){});
  SAUDetailRouteModel data = SAUDetailRouteModel(titleModel:titleModel,
      cardList:[],
      buttonRoles:[]);
  return data;
}

SAUDetailCardModel todoCard(String title) {
  Map itemData = {'key': 'TODO',
    'value': title,
  };
  return SAUDetailCardModel(title:title,resultList:[itemData], tapTitle:(BuildContext context,VoidCallback refreshAction){});
}

SAUDetailCardModel outErrorCard(int index,List<SAUDetailCardModel> cardList) {
  Map indexData = {'key': 'index',
    'value': index.toString(),
  };

  Map lengthData = {'key': 'length',
    'value': '${cardList.length}',
  };
  return SAUDetailCardModel(title:'越界',resultList:[indexData,lengthData], tapTitle:(BuildContext context,VoidCallback refreshAction){});
}


