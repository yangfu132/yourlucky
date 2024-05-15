import 'package:flutter_test/flutter_test.dart';
import 'package:your_lucky/src/D_Business/DigitModel/sab_easy_digit_model.dart';
import 'package:your_lucky/src/D_Business/EasyWords/sab_easy_words_business.dart';
import 'package:your_lucky/src/D_Business/EasyWords/sab_month_model.dart';

void main() {
  test('my first unit test', () {
    var answer = 42;
    expect(answer, 42);
  });

  test('bMovement', () {
    SABMonthModel dataModel;
    dataModel = generateTestModel([0, 8, 0, 1, 1, 1]);
    expect(dataModel.skyEarth() == "癸丑", true);
  });
}

SABMonthModel generateTestModel(List<int> listEasyData) {
  String strEasyGoal = "单元测试";
  String strUsefulDeity = "子孙";
  String stringTime = "2023-01-28 15:27:27";
  //[0, 8, 0, 1, 1, 1]
  //[8, 8, 0, 8, 0, 0]
  //[0, 1, 1, 8, 8, 1]
  SABEasyDigitModel inputEasyModel;
  inputEasyModel = SABEasyDigitModel(
    modelId: null,
    strEasyGoal: strEasyGoal,
    strUsefulDeity: strUsefulDeity,
    stringTime: stringTime,
    listEasyData: listEasyData,
  );
  SABEasyWordsBusiness wordsBusiness = SABEasyWordsBusiness(inputEasyModel);
  return wordsBusiness.outEasyWordsModel().monthModel;
}
