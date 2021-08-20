import 'package:flutter/material.dart';
import 'package:yourlucky/src/2L_UI/Base/Widget/toast.dart';
import 'package:yourlucky/src/3L_Business/User/SABLogInBusiness.dart';
import 'package:yourlucky/src/4L_Service/SASLocalizationsService.dart';

class SAULoginRoute extends StatefulWidget {
  SAULoginRoute({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  SAULoginRouteState createState() {
    return SAULoginRouteState();
  }
}

class SAULoginRouteState extends State<SAULoginRoute> {
  final SABLogInBusiness business = SABLogInBusiness();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SASLocalizationsService.userLogIn(context)),
      ),
      body: business.isLogged() ? buildLogged(context) : buildLogIn(context),
    );
  }

  Widget buildLogged(BuildContext context) {
    return Text("你已经登录！");
  }

  Widget buildLogIn(BuildContext context) {
    return ListView.builder(
        itemCount: 4,
        itemExtent: 50.0, //强制高度为50.0
        itemBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return TextField(
                controller: business.emailController,
                style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
                decoration: InputDecoration(
                  hintText: '请输入email',
                  hintStyle: TextStyle(fontSize: 14, color: Color(0xFFCCCCCC)),
                  border: InputBorder.none,
                ),
                textInputAction: TextInputAction.next,
                focusNode: business.emailFocus,
              );
            case 1:
              return TextField(
                controller: business.passwordController,
                style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
                decoration: InputDecoration(
                  hintText: '请输入密码',
                  hintStyle: TextStyle(fontSize: 14, color: Color(0xFFCCCCCC)),
                  border: InputBorder.none,
                ),
                textInputAction: TextInputAction.done,
                focusNode: business.passwordFocus,
              );
            case 2:
              return TextButton(
                onPressed: () => business.logIn((String code, String message) {
                  ToastWidget.show("message:" + message);
                  // Navigator.pop(context);
                }),
                child: Text(SASLocalizationsService.userLogIn(context)),
              );
            default:
              return Container();
          }
        });
  }
}
