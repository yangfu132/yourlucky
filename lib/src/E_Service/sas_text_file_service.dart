import 'dart:io';

import 'package:flutter/services.dart';

import 'Base/sas_base_service.dart';
class SASTextFileService extends SABBaseService {

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

  static Future<void> readAsset(void Function(String content) refresh) async {
    String result = "waiting";
    try{
      String assetPath = "assets/easy.txt";
      result = await rootBundle.loadString(assetPath);
    }catch(e){
      result = "failed";
      SABBaseService.staticPrintMsg(e as String?);
    }
    refresh(result);
  }

  static Future<void> readFile(void Function(String content) refresh) async {
    String result = "waiting";
    try{
      String filePath = 'something like path,not asset';
      File file = File(filePath);
      //text_viewer_page中是这样写的： result = file.readAsStringSync();
      result = await file.readAsString();
      SABBaseService.staticPrintMsg(result);
    }catch(e){
      result = "failed";
      SABBaseService.staticPrintMsg(e as String?);
    }
    refresh(result);
  }
}
