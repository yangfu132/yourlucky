import 'package:flutter/material.dart';
import 'package:yourlucky/src/1L_Context/SACNavigator.dart';
import 'package:yourlucky/src/1L_Context/SACRouteUrl.dart';
import 'package:yourlucky/src/4L_Service/SASLocalizationsService.dart';

class SAUUserRoute extends StatefulWidget {
  SAUUserRoute({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  SAUUserRouteState createState() {
    return SAUUserRouteState();
  }
}

class SAUUserRouteState extends State<SAUUserRoute> {
  List<Map> userActionData(BuildContext context) {
    return <Map>[
      {
        'value': SACRouteUrl.history,
        'key': SASLocalizationsService.userFeedback(context)
      },
      {
        'value': SACRouteUrl.history,
        'key': SASLocalizationsService.userDevelopTask(context)
      },
      {
        'value': SACRouteUrl.history,
        'key': SASLocalizationsService.userFriends(context)
      },
      {
        'value': SACRouteUrl.history,
        'key': SASLocalizationsService.userAbout(context)
      },
      {
        'value': SACRouteUrl.history,
        'key': SASLocalizationsService.userRateAndReview(context)
      },
      {
        'value': SACRouteUrl.history,
        'key': SASLocalizationsService.userSetting(context)
      },
      {
        'value': SACRouteUrl.logIn,
        'key': SASLocalizationsService.userLogIn(context)
      },
      {
        'value': SACRouteUrl.history,
        'key': SASLocalizationsService.userDebug(context)
      },
      {'value': SACRouteUrl.expertCategory, 'key': '趋避'},
      {
        'value': SACRouteUrl.history,
        'key': SASLocalizationsService.userHistory(context)
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    List userActionList = userActionData(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(SASLocalizationsService.homeUser(context)),
      ),
      body: ListView.builder(
          itemCount: userActionList.length,
          itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            int kv = index % 2;
            if (kv > 0) {
              return ListTile(
                trailing: Icon(Icons.chevron_right, color: Colors.grey),
                title: Text(userActionList[index]['key']),
                onTap: () {
                  SACNavigator.pushNamed(
                    context,
                    userActionList[index]['value'],
                  );
                },
              );
            } else {
              return Container(
                //color: Colors.grey,
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: ListTile(
                  trailing: Icon(Icons.chevron_right, color: Colors.white),
                  title: Text(userActionList[index]['key']),
                  onTap: () {
                    SACNavigator.pushNamed(
                      context,
                      userActionList[index]['value'],
                    );
                  },
                ),
              );
            } // End if
          }),
    );
  }
}
