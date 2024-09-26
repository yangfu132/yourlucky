
import 'package:flutter/material.dart';

class SAUTextField extends StatefulWidget {
  final TextField textField;
  final FocusNode focusNode;

  const SAUTextField({required this.textField, required this.focusNode})
      : super();

  @override
  _SAUTextFieldState createState() => _SAUTextFieldState();
}

class _SAUTextFieldState extends State<SAUTextField> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
