import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_navigator.dart';
import 'package:your_lucky/src/A_Context/sac_route_url.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/sau_toast_widget.dart';
import 'package:your_lucky/src/D_Business/User/sab_login_business.dart';
import 'package:your_lucky/src/E_Service/sas_localizations_service.dart';

class SAUSetPasswordRoute extends StatefulWidget {
  const SAUSetPasswordRoute({super.key, this.title});
  final String? title;
  @override
  SAUSetPasswordRouteState createState() {
    return SAUSetPasswordRouteState();
  }
}

class SAUSetPasswordRouteState extends State<SAUSetPasswordRoute> {
  final SABLogInBusiness business = SACContext.login();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody () {
    double screenWidth = SACContext.screenWidth(context);
    double screenHeight = SACContext.screenHeight(context);
    return Center(
        child: Stack(
          children: <Widget>[
            Image.asset(
              'images/8466654.jpg',
              width: screenWidth,
              height: screenHeight,
              fit: BoxFit.fill,
            ),
            Positioned(
              left: 15,
              right: 15,
              top: 60,
              bottom: 30,
              child:Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.white,
                ),
                child: business.isLogged() ? buildLogged(context) : buildLogIn(context),
              ),
            ),
          ],
        ),
    );
  }

  Widget buildLogged(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemExtent: 50.0, //强制高度为50.0
        itemBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return const Text("你已经登录！");
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
              return  Row(
                children: [
                  SizedBox(width: 15,),
                  Text('用户邮箱:        '),
                  Expanded(
                    child: TextField(
                      controller: business.emailController,
                      style: const TextStyle(fontSize: 14, color: Color(0xFF333333)),
                      decoration: const InputDecoration(
                        hintText: '请输入邮箱',
                        hintStyle: TextStyle(fontSize: 14, color: Color(0xFFCCCCCC)),
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.done,
                      focusNode: business.emailFocus,
                    ),
                  ),
                ],
              );
            case 1:
              return  Row(
                children: [
                  SizedBox(width: 15,),
                  Text('输入密码:        '),
                  Expanded(
                    child: TextField(
                      controller: business.passwordController,
                      style: const TextStyle(fontSize: 14, color: Color(0xFF333333)),
                      decoration: const InputDecoration(
                        hintText: '请输入密码',
                        hintStyle: TextStyle(fontSize: 14, color: Color(0xFFCCCCCC)),
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.done,
                      focusNode: business.passwordFocus,
                    ),
                  ),
                ],
              );
            case 2:
          return  Row(
            children: [
              SizedBox(width: 15,),
              Text('确认密码:        '),
              Expanded(
                child: TextField(
                      controller: business.confirmController,
                      style: const TextStyle(fontSize: 14, color: Color(0xFF333333)),
                      decoration: const InputDecoration(
                        hintText: '请再次输入密码',
                        hintStyle: TextStyle(fontSize: 14, color: Color(0xFFCCCCCC)),
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.done,
                      focusNode: business.confirmFocus,
                    ),
                  ),
                ],
              );
            case 3:
              return Row(children: [
                Expanded(child:  TextButton(
                  onPressed: () => SACNavigator.pop(context),
                  child: Text(
                    SASLocalizationsService.userCancel(context),
                    style: TextStyle(fontSize: 16, color: Color(0xFF333333),),
                  ),
                ),),
                Expanded(child:  TextButton(
                  onPressed: () => business.setPassword((String code, String message) {
                    SAUToastWidget.show("message:$message");
                    debugPrint(message);
                    if ('成功' == message) {
                      SACNavigator.pop(context);
                    }
                  }),
                  child: Text(
                    SASLocalizationsService.userConfirm(context),
                    style: TextStyle(fontSize: 16, color: Color(0xFF333333),),
                  ),
                ),),
              ],);
            default:
              return Container();
          }
        });
  }


  void resultAction(BuildContext context) {
    SACNavigator.pushNamed(
        context,
        SACRouteUrl.logIn,
        null
    );
  }

  Widget resultActionTitle() {
    final SABLogInBusiness business = SACContext.login();
    if (business.displayName().isNotEmpty) {
      return Text(business.displayName());
    } else {
      return Text(SASLocalizationsService.setPassword(context));
    }
  }

  IconButton backIconButton(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        });
  }
}
