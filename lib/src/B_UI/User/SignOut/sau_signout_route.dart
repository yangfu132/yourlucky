import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_navigator.dart';
import 'package:your_lucky/src/A_Context/sac_route_url.dart';

class SAUSignOutRoute extends StatefulWidget {
  const SAUSignOutRoute({super.key, this.title});
  final String? title;
  @override
  SAUSignOutRouteState createState() {
    return SAUSignOutRouteState();
  }
}

class SAUSignOutRouteState extends State<SAUSignOutRoute> {
  List settingsList = <Map>[
    {'value': SACRouteUrl.feedback, 'key': 'Feedback'},
    {'value': SACRouteUrl.developer, 'key': 'Develop Task'},
    {'value': SACRouteUrl.friends, 'key': 'Friends'},
    {'value': SACRouteUrl.about, 'key': 'About'},
    {'value': SACRouteUrl.rateAndReview, 'key': 'Rate And Review'},
    {'value': SACRouteUrl.setting, 'key': 'Setting'},
    {'value': SACRouteUrl.logIn, 'key': 'Log In'},
    {'value': SACRouteUrl.logOut, 'key': 'Log Out'},
    {'value': SACRouteUrl.debug, 'key': 'Debug'},
    {'value': SACRouteUrl.expertCategory, 'key': '趋避'},
    {'value': SACRouteUrl.history, 'key': 'History'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Out'),
      ),
      body: ListView.builder(
          itemCount: settingsList.length,
          itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            int kv = index % 2;
            if (kv > 0) {
              return ListTile(
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                title: Text(settingsList[index]['key']),
                onTap: () {
                  SACNavigator.pushNamed(
                      context,
                      settingsList[index]['value'],
                      null
                  );
                },
              );
            } else {
              return Container(
                //color: Colors.grey,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
                child: ListTile(
                  trailing: const Icon(Icons.chevron_right, color: Colors.white),
                  title: Text(settingsList[index]['key']),
                  onTap: () {
                    SACNavigator.pushNamed(
                      context,
                      settingsList[index]['value'],
                      null
                    );
                  },
                ),
              );
            } // End if
          }),
    );
  }
}
