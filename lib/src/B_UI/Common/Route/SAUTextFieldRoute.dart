import 'package:flutter/material.dart';
import 'package:yourlucky/src/B_UI/Common/Widget/Button/SAUBottomButtonBar.dart';
import 'package:yourlucky/src/B_UI/Common/Widget/Button/SAUBottomButtonBarModel.dart';

import 'SAUTextFieldRouteModel.dart';

typedef SaveTextFieldRouteCallback = void Function(SAUTextFieldRouteModel model);

class SAUTextFieldRoute extends StatefulWidget {
  SAUTextFieldRoute({Key? key, this.title, required this.model,required this.onSave}) : super(key: key);
  final String? title;
  final SAUTextFieldRouteModel model;
  final SaveTextFieldRouteCallback onSave;
  @override
  SAUTextFieldRouteState createState() {
    return SAUTextFieldRouteState();
  }
}

class SAUTextFieldRouteState extends State<SAUTextFieldRoute> {
  final textController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model.stringTitle),
      ),
      body: Column(
        children:[
          Expanded(
              child:_textField()
          ),
          SAUBottomButtonBar(
              model:SAUBottomButtonBarModel.save(),
              onTap:(SAUButtonModel itemModel){
                widget.onSave(widget.model);
              }
          ),
        ],
      ),
    );
  }

  Widget _textField (){
    return TextField(
      controller: textController,
      style: TextStyle(fontSize: 14,color: Color(0xFF333333)),
      decoration: InputDecoration(
        hintText: widget.model.stringPlaceholder,
        hintStyle: TextStyle(fontSize: 14, color: Color(0xFFCCCCCC)),
        border: InputBorder.none,
      ),
      minLines: 1,
      maxLines: 1,
      keyboardType: TextInputType.number,
      onChanged: (value){
      },
    );
  }
}
