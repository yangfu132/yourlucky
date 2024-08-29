import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_navigator.dart';
import 'package:your_lucky/src/A_Context/sac_route_url.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/sau_toast_widget.dart';
import 'package:your_lucky/src/D_Business/User/sab_login_business.dart';
import 'package:your_lucky/src/E_Service/sas_localizations_service.dart';

class SAUSignInRoute extends StatefulWidget {
  const SAUSignInRoute({super.key, this.finishBlock});
  final VoidCallback? finishBlock;
  @override
  SAUSignInRouteState createState() {
    return SAUSignInRouteState();
  }
}

class SAUSignInRouteState extends State<SAUSignInRoute> {
  final SABLogInBusiness business = SACContext.login();


  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage('images/8466654.jpg'),
              // NetworkImage(
              //     'https://i-blog.csdnimg.cn/blog_migrate/46fe176149f7cf1c2520bb349eba9039.jpeg'),
              fit: BoxFit.fill,
            )),
        child: Scaffold(
          backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
          appBar: AppBar(
            leading: backIconButton(context),
            backgroundColor: Colors.transparent,
            title: const Text(
              '登录',
              style: TextStyle(
                color: Color(0xFFE5CC69),
              ),
            ),
          ),
          body: _buildBody(context),
        )
    );
  }

  Widget _buildBody (BuildContext context) {
    double screenWidth = SACContext.screenWidth(context);
    double screenHeight = SACContext.screenHeight(context);
    return Center(
      child: Stack(
        children: <Widget>[
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
                Expanded(child: business.isLogged() ? buildLogged(context) : buildLogIn(context),),
              ],),
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
                  if ('0' == code) {
                    if (null != widget.finishBlock){
                      widget.finishBlock!();
                    }
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
    final SABLogInBusiness business = SACContext.login();
    String buttonTitle = '';
    if (business.hasUser) {
      buttonTitle = SASLocalizationsService.userForget(context);
    } else {
      buttonTitle = SASLocalizationsService.signUp(context);
    }

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
              return Text('');
            case 3:
              return Row(children: [
                Expanded(child:  TextButton(
                  onPressed: () {
                    business.signIn((code, message) {
                      if (code == '0') {
                        if (null != widget.finishBlock){
                          widget.finishBlock!();
                        }
                        SACNavigator.pop(context);
                      } else {
                        SAUToastWidget.show("$message");
                      }

                    });

                  },
                  child: Text(
                    SASLocalizationsService.userLogIn(context),
                    style: TextStyle(fontSize: 16, color: Color(0xFF333333),),
                  ),
                ),),
                Expanded(child:  TextButton(
                  onPressed: () {
                    business.sendPasswordResetEmail(context);
                  },
                  child: Text(buttonTitle,
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

  IconButton backIconButton(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        });
  }
}
