
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SAUTransparentWidget extends StatelessWidget {
  const SAUTransparentWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent, // 设置AppBar为透明
      elevation: 0, // 去除AppBar的阴影
      automaticallyImplyLeading: false,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,//设置状态栏的背景颜色
        statusBarIconBrightness: Brightness.dark,//状态栏的文字的颜色
      ),
    );
  }
}