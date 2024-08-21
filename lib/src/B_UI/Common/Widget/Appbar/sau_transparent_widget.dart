
import 'package:flutter/material.dart';

class SAUTransparentWidget extends StatelessWidget {
  const SAUTransparentWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent, // 设置AppBar为透明
      elevation: 0, // 去除AppBar的阴影
      automaticallyImplyLeading: false,
    );
  }
}