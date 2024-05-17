import 'package:flutter/material.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/Button/sau_bottom_button_bar.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/Button/sau_bottom_button_bar_model.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/Button/sau_button_model.dart';

import 'sau_textfield_route_model.dart';

typedef SaveTextFieldRouteCallback = void Function(SAUTextFieldRouteModel model);

class SAUTextFieldRoute extends StatefulWidget {
  SAUTextFieldRoute({super.key, required this.model,required this.onSave});
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
                widget.model.stringValue = textController.text;
                widget.onSave(widget.model);
              }
          ),
        ],
      ),
    );
  }

  Widget _textField (){
    textController.text = widget.model.stringValue;
    return TextField(
      controller: textController,
      style: const TextStyle(fontSize: 14,color: Color(0xFF333333)),
      decoration: InputDecoration(
        hintText: widget.model.stringPlaceholder,
        hintStyle: const TextStyle(fontSize: 14, color: Color(0xFFCCCCCC)),
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
