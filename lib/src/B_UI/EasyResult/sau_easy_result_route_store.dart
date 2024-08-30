import 'package:flutter/material.dart';
import 'package:flutter_perpttual_calendar/flutter_perpttual_calendar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_detail_route.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_route_title_model.dart';
import 'package:your_lucky/src/B_UI/Common/Route/sau_textfield_route.dart';
import 'package:your_lucky/src/B_UI/Common/Route/sau_textfield_route_model.dart';
import 'package:your_lucky/src/B_UI/EasyResult/sas_buddha_service.dart';
import 'package:your_lucky/src/B_UI/EasyResult/sau_avoid_evil_route_store.dart';
import 'package:your_lucky/src/B_UI/EasyResult/sau_seak_future_route_store.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_easy_detail_model.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/BaseLogic/sab_easy_logic_business.dart';
import 'package:your_lucky/src/E_Service/sas_localizations_service.dart';

class SAUEasyResultRouteStore extends SABBaseModel {
  SAUEasyResultRouteStore({required this.detailModel});
  final SABEasyDetailModel detailModel;
  SAURouteTitleModel titleModel(){
    return SAURouteTitleModel.emptyTitleModel();
  }

  void loadData(void Function(String content) finish){
    String strResult = '平';
    bool isFuture = getFuture();
    bool isEvil = getEvil();
    if (isEvil) {
      strResult = '凶';
    } else if (isFuture) {
      strResult = '吉';
    }
    finish(strResult);
  }

  bool getEvil (){
    bool bResult = false;
    ///官鬼持世
    if ('官鬼' == detailModel.wordsModel().getLifeParent()) {
      bResult = true;
    } else {
      int nRow = detailModel.wordsModel().getLifeIndex();
      final healthSymbol = detailModel.healthModel().symbol(nRow, EasyTypeEnum.from);
      bool isStrong = healthSymbol?.isStrong() ?? false;
      ///世弱
      if (!isStrong) {
        bResult = true;
      } else {
        String parentGoal = getParentOnGoal();
        ///应克世
        if ('官鬼' == parentGoal) {
          bResult = true;
        } else {
          bool isMovement = detailModel.digitModel().isMovementAtRow(nRow);
          if (isMovement) {
            String parentTo = detailModel.wordsModel().getSymbolParent(nRow, EasyTypeEnum.to);
            ///化鬼
            if ('官鬼' == parentTo) {
              bResult = true;
            } else {
              ///化克
              if (detailModel.logicModel().getIsSymbolChangeRestrict(nRow)) {
                bResult = true;
              } //else {}
            }
          }
        }
      }
    }
    return bResult;
  }

  String getParentOnGoal(){
    int nRow = detailModel.wordsModel().getLifeIndex();
    int goalIndex = detailModel.wordsModel().getGoalIndex();
    SABEasyLogicBusiness logicBusiness = SABEasyLogicBusiness(detailModel.digitModel());
    String parentGoal = logicBusiness.getParent(nRow,goalIndex);
    return parentGoal;
  }

  String getParentOnDeity(){
    int nRow = detailModel.getUsefulDeity().symbolRow;
    int goalIndex = detailModel.wordsModel().getGoalIndex();
    SABEasyLogicBusiness logicBusiness = SABEasyLogicBusiness(detailModel.digitModel());
    String parentGoal = logicBusiness.getParent(nRow,goalIndex);
    return parentGoal;
  }

  bool getFuture (){
    bool bResult = false;
    /// 1. 应生世
    final parentGoal = getParentOnGoal();
    if ('父母' == parentGoal) {
      bResult = true;
    } else {
      /// 2. 用生世
      final parentGoal = getParentOnDeity();
      if ('父母' == parentGoal) {
        bResult = true;
      }
    }
    return bResult;
  }

  //趋吉
  void gotoSeekFortuneDetail(BuildContext context) {
    int uiRow = detailModel.getUsefulDeity().symbolRow + 1;
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      final store = SAUSeekFutureRouteStore(
          inputDetailModel:detailModel,
          uiRow: uiRow,
          easyType: detailModel.getUsefulDeity().easyType
      );
        return SAUDetailRoute(store:store);
    }));
  }

  //避凶
  void gotoAvoidEvilDetail(BuildContext context) {
    int uiRow = detailModel.getUsefulDeity().symbolRow + 1;
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      final store = SAUAvoidEvilRouteStore(
          inputDetailModel:detailModel,
          uiRow: uiRow,
          easyType: detailModel.getUsefulDeity().easyType
      );
      return SAUDetailRoute(store:store);
    }));
  }

  void gotoUrl(BuildContext context){
    final buddha = SASBuddhaService();
    _launchUrl(buddha.getPath());
  }

  Future<void> _launchUrl(String path) async {
    final Uri url = Uri.parse(path);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void gotoTextField(BuildContext context) {
    String stringValue = detailModel.digitModel().strEasyGoal;
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      SAUTextFieldRouteModel model = SAUTextFieldRouteModel(
        stringTitle: SASLocalizationsService.easyNamed(context),
        stringValue: stringValue,
        stringPlaceholder: "请输入",
      );
      return SAUTextFieldRoute(
        model: model,
        onSave: (SAUTextFieldRouteModel model) {
          detailModel.digitModel().strEasyGoal = model.stringValue;
          SACContext.easyStore().save(detailModel.digitModel());
          Navigator.pop(context);
        },
      );
    }));
  }
}