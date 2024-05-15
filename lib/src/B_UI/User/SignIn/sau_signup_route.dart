import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_navigator.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/sau_toast_widget.dart';
import 'package:your_lucky/src/D_Business/User/sab_login_business.dart';
import 'package:your_lucky/src/E_Service/sas_localizations_service.dart';

class SAUSignupRoute extends StatefulWidget {
  SAUSignupRoute({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  SAUSignupRouteState createState() {
    return SAUSignupRouteState();
  }
}

class SAUSignupRouteState extends State<SAUSignupRoute> {
  final SABLogInBusiness business = SABLogInBusiness();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SASLocalizationsService.userSignUp(context)),
      ),
      body: business.isLogged() ? buildLogged(context) : buildLogIn(context),
    );
  }

  Widget buildLogged(BuildContext context) {
    return const Text("你已经登录！");
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
                style: const TextStyle(fontSize: 14, color: Color(0xFF333333)),
                decoration: const InputDecoration(
                  hintText: '请输入email',
                  hintStyle: TextStyle(fontSize: 14, color: Color(0xFFCCCCCC)),
                  border: InputBorder.none,
                ),
                textInputAction: TextInputAction.next,
                focusNode: business.emailFocus,
              );
            case 1:
              return TextField(
                controller: business.nameController,
                style: const TextStyle(fontSize: 14, color: Color(0xFF333333)),
                decoration: const InputDecoration(
                  hintText: '请输入用户名',
                  hintStyle: TextStyle(fontSize: 14, color: Color(0xFFCCCCCC)),
                  border: InputBorder.none,
                ),
                textInputAction: TextInputAction.next,
                focusNode: business.nameFocus,
              );
            case 2:
              return TextField(
                controller: business.passwordController,
                style: const TextStyle(fontSize: 14, color: Color(0xFF333333)),
                decoration: const InputDecoration(
                  hintText: '请输入密码',
                  hintStyle: TextStyle(fontSize: 14, color: Color(0xFFCCCCCC)),
                  border: InputBorder.none,
                ),
                textInputAction: TextInputAction.done,
                focusNode: business.passwordFocus,
              );
            case 3:
              return TextButton(
                onPressed: () => business.signUp((String code, String message) {
                  SAUToastWidget.show("message:" + message);
                  SACNavigator.pop(context);
                }),
                child: Text(SASLocalizationsService.userSignUp(context)),
              );

            default:
              return Container();
          }
        });
  }
}
