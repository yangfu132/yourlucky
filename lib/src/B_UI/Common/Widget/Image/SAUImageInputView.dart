import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SAUUploadImageView.dart';

class SAUImageInputView extends StatelessWidget {
  final String title;
  final List<String> urls;
  final ValueChanged<List<String>>? imageChanged;
  final bool isEdit;
  final EdgeInsets? padding;
  final EdgeInsets? imagePadding;

  SAUImageInputView(
      {required this.title,
        required this.urls,
        this.imageChanged,
        this.isEdit = true,
        this.padding,
        this.imagePadding});

  @override
  Widget build(BuildContext context) {
    final padding = this.padding ?? EdgeInsets.only(top: 16);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: padding,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
              ),
            ),
          ),
          _buildImage(),
        ],
      ),
    );
  }

  Widget _buildImage() {
    final imagePadding =
        this.imagePadding ?? EdgeInsets.only(top: 5, bottom: 8);
    return Container(
        child: SAUUploadImageView(
          urls,
          isEdit,
          1,
          padding: imagePadding,
          changeBack: imageChanged,
        ));
  }
}
