
import 'package:flutter/material.dart';

class SAUTextField extends StatefulWidget {
  final TextField textField;
  final FocusNode focusNode;

  const SAUTextField({super.key, required this.textField, required this.focusNode});

  @override
  State<SAUTextField> createState() => _SAUTextFieldState();
}

class _SAUTextFieldState extends State<SAUTextField> {
  @override void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
