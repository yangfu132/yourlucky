import 'package:flutter/material.dart';

class SAULoginRoute extends StatefulWidget {
  SAULoginRoute({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  SAULoginRouteState createState() {
    return SAULoginRouteState();
  }
}

class SAULoginRouteState extends State<SAULoginRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
      ),
      body: ListView.builder(
          itemCount: 3,
          itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            switch (index) {
              case 0:
                return TextField(
                  style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
                  decoration: InputDecoration(
                    hintText: '请输入email',
                    hintStyle:
                        TextStyle(fontSize: 14, color: Color(0xFFCCCCCC)),
                    border: InputBorder.none,
                  ),
                  textInputAction: TextInputAction.next,
                );
              case 1:
                return TextField(
                  style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
                  decoration: InputDecoration(
                    hintText: '请输入密码',
                    hintStyle:
                        TextStyle(fontSize: 14, color: Color(0xFFCCCCCC)),
                    border: InputBorder.none,
                  ),
                  textInputAction: TextInputAction.next,
                );
              case 2:
                return TextButton(
                  onPressed: () => print('111'),
                  child: Text('登录'),
                );
              default:
                return Container();
            }
          }),
    );
  }
}
