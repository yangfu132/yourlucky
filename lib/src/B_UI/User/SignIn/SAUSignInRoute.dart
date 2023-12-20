import 'package:flutter/material.dart';
import 'package:yourlucky/src/A_Context/SACNavigator.dart';
import 'package:yourlucky/src/A_Context/SACRouteUrl.dart';
import 'package:yourlucky/src/B_UI/Common/Widget/toast.dart';
import 'package:yourlucky/src/D_Business/User/SABLogInBusiness.dart';
import 'package:yourlucky/src/E_Service/SASLocalizationsService.dart';

class SAUSignInRoute extends StatefulWidget {
  SAUSignInRoute({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  SAUSignInRouteState createState() {
    return SAUSignInRouteState();
  }
}

class SAUSignInRouteState extends State<SAUSignInRoute> {
  final SABLogInBusiness business = SABLogInBusiness();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(business.displayName() ??
            SASLocalizationsService.userLogIn(context)),
      ),
      body: business.isLogged() ? buildLogged(context) : buildLogIn(context),
    );
  }

  Widget buildLogged(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemExtent: 50.0, //强制高度为50.0
        itemBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return Text("你已经登录！");
            case 1:
              return TextButton(
                onPressed: () => business.signOut((code, message) {
                  if ('成功' == message) {
                    SACNavigator.pop(context);
                  }
                }),
                child: Text(SASLocalizationsService.userSignOut(context)),
              );
            default:
              return Container();
          }
        });
  }

  Widget buildLogIn(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
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
                onPressed: () => business.signIn((String code, String message) {
                  ToastWidget.show("message:" + message);
                  print(message);
                  if ('成功' == message) {
                    SACNavigator.pop(context);
                  }
                }),
                child: Text(SASLocalizationsService.userLogIn(context)),
              );
            case 3:
              return TextButton(
                onPressed: () {
                  business.sendPasswordResetEmail();
                  ToastWidget.show("请前往邮箱查看重置邮件。");
                },
                child: Text(SASLocalizationsService.userForget(context)),
              );

            case 4:
              return TextButton(
                onPressed: () => SACNavigator.pushNamed(
                  context,
                  SACRouteUrl.signUp,
                ),
                child: Text(SASLocalizationsService.userSignUp(context)),
              );

            default:
              return Container();
          }
        });
  }
}
