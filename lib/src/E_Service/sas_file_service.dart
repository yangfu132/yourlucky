import 'dart:io';

import 'package:flutter/services.dart';

import 'Base/sas_base_service.dart';
class SASFileService extends SABBaseService {
  void writeFile (String content) async {
    File file = File('test.txt');
    try {
      // 向文件写入字符串
      await file.writeAsString(content);
      printMsg('Data written.');
    } catch (e) {
      printMsg(e as String?);
    }
  }

  static Future<void> readFile(void Function(String content) refresh) async {
    String result = "waiting";
    try{
      final temp = await rootBundle.load("assets/easy.txt");
      final aaa = temp as String?;
      result = aaa ?? "failed";
      SABBaseService.staticPrintMsg(result);
    }catch(e){
      result = "failed";
      SABBaseService.staticPrintMsg(e as String?);
    }
    refresh(result);
  }

  static Future<void> readFileOld(void Function(String content) refresh) async {
    String result = "waiting";
    File file = File('assets/easy.txt');
    try{
      result = await file.readAsString();
      SABBaseService.staticPrintMsg(result);
    }catch(e){
      result = "failed";
      SABBaseService.staticPrintMsg(e as String?);
    }
    refresh(result);
  }


}
