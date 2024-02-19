import 'dart:io';

import 'package:flutter/services.dart';

import 'Base/SABBaseService.dart';
class SASFileService extends SABBaseService {
  void writeFile (String content) async {
    File file = new File('test.txt');
    try {
      // 向文件写入字符串
      await file.writeAsString(content);
      print('Data written.');
    } catch (e) {
      print(e);
    }
  }


  static Future<void> readFile(void refresh(String content)) async {
    String result = "waiting";
    try{
      final temp = await rootBundle.load("assets/easy.txt");
      final aaa = temp as String;
      result = null != aaa ? aaa : "failed";
      print(result);
    }catch(e){
      result = "failed";
      print(e);
    }
    refresh(result);
  }

  static Future<void> readFile_old(void refresh(String content)) async {
    String result = "waiting";
    File file = new File('assets/easy.txt');
    try{
      result = await file.readAsString();
      print(result);
    }catch(e){
      result = "failed";
      print(e);
    }
    refresh(result);
  }


}
