import 'package:flutter/material.dart';

class SAUListTitleVisitor {
  static Widget greyWhite(
      int index, String stringTitle, GestureTapCallback? tapCallback) {
    int kv = index % 2;
    if (kv > 0) {
      return ListTile(
        trailing: Icon(Icons.chevron_right, color: Colors.grey),
        title: Text(stringTitle),
        onTap: tapCallback,
      );
    } else {
      return Container(
        //color: Colors.grey,
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
        child: ListTile(
          trailing: Icon(Icons.chevron_right, color: Colors.white),
          title: Text(stringTitle),
          onTap: tapCallback,
        ),
      );
    } // E
  }
}
