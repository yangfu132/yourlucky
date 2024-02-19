import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';

class SABEasyInfoSymbolModel extends SABBaseModel {
  SABEasyInfoSymbolModel({
    required this.textClassical,
    required this.textTranslate,
    required this.likeClassical,
    required this.likeTranslate,
  });

  ///原文古文
  final String textClassical;

  ///原文译文
  final String textTranslate;

  ///象文古文
  final String likeClassical;

  ///象文译文
  final String likeTranslate;
}
