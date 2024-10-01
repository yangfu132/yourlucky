import 'package:flutter/material.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/Button/sau_bottom_button_bar.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/Button/sau_bottom_button_bar_model.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/Button/sau_button_model.dart';

import 'sau_textfield_route_model.dart';

typedef SaveTextFieldRouteCallback = void Function(SAUTextFieldRouteModel model);

class SAUTextFieldRoute extends StatefulWidget {
  const SAUTextFieldRoute({super.key, required this.model,required this.onSave});
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
  Widget build_new(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image:ExactAssetImage('images/8466654.jpg'),
              // NetworkImage(
              //     'https://i-blog.csdnimg.cn/blog_migrate/46fe176149f7cf1c2520bb349eba9039.jpeg'),
              fit: BoxFit.fill,
            )),
        child: Scaffold(
          backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
          appBar: AppBar(
            leading: backIconButton(context),
            backgroundColor: Colors.transparent,
            title:Text(
              widget.model.stringTitle,
              style: TextStyle(
                color: Color(0xFFE5CC69),
              ),
            ),
          ),
          body: Column(
            children:[
              Positioned(
                left: 15,
                right: 15,
                top: 10,
                bottom: 30,
                child:Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: Column(children: [
                    SizedBox(height: 15,),
                    Expanded(
                        child: _textField()
                    ),
                  ],),
                ),
              ),

              // SAUBottomButtonBar(
              //     model:SAUBottomButtonBarModel.save(),
              //     onTap:(SAUButtonModel itemModel){
              //       widget.model.stringValue = textController.text;
              //       widget.onSave(widget.model);
              //     }
              // ),
            ],),
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image:ExactAssetImage('images/8466654.jpg'),
              // NetworkImage(
              //     'https://i-blog.csdnimg.cn/blog_migrate/46fe176149f7cf1c2520bb349eba9039.jpeg'),
              fit: BoxFit.fill,
            )),
        child: Scaffold(
          backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
          appBar: AppBar(
            leading: backIconButton(context),
            backgroundColor: Colors.transparent,
            title:Text(
              widget.model.stringTitle,
              style: TextStyle(
                color: Color(0xFFE5CC69),
              ),
            ),
          ),
          body: Column(
            children:[
              Expanded(
                  child:Row(children: [
                    SizedBox(width: 15,),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Colors.white,
                        ),
                        child:Column(
                          children: [
                            SizedBox(height: 30,),
                            _textField(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 15,),
                  ],),
              ),
              SizedBox(height: 30,),
              SAUBottomButtonBar(
                  model:SAUBottomButtonBarModel.save(),
                  onTap:(SAUButtonModel itemModel){
                    widget.model.stringValue = textController.text;
                    widget.onSave(widget.model);
                  }
              ),
            ],
          ),
        )
    );
  }

  @override
  Widget build_old(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backIconButton(context),
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
        filled: true,
        fillColor: Colors.white,
      ),
      minLines: 1,
      maxLines: 1,
      keyboardType: TextInputType.text,
      onChanged: (value){
      },
    );
  }

  IconButton backIconButton(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        color: Color(0xFFE5CC69),
        onPressed: () {
          Navigator.pop(context);
        });
  }
}
