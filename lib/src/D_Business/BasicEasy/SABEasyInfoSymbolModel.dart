import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';

class SABEasyInfoSymbolModel extends SABBaseModel {
  SABEasyInfoSymbolModel({
    required this.originalClassic,
    required this.originalTranslate,
    required this.likeClassic,
    required this.likeTranslate,
  });
  //{"原文古文":"","原文译文":"","象文古文":"","象文译文":""},
  final String originalClassic; ///原文古文
  final String originalTranslate; ///译文古文
  final String likeClassic;     ///象文古文
  final String likeTranslate;   ///象文译文
}
