import 'package:flutter/material.dart';
import 'package:yourlucky/src/1L_Context/SACNavigator.dart';
import 'package:yourlucky/src/1L_Context/SACRouteUrl.dart';

class SAULogOutRoute extends StatefulWidget {
  SAULogOutRoute({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  SAULogOutRouteState createState() {
    return SAULogOutRouteState();
  }
}

class SAULogOutRouteState extends State<SAULogOutRoute> {
  List settingsList = <Map>[
    {'value': SACRouteUrl.history, 'key': 'Feedback'},
    {'value': SACRouteUrl.history, 'key': 'Develop Task'},
    {'value': SACRouteUrl.history, 'key': 'Friends'},
    {'value': SACRouteUrl.history, 'key': 'About'},
    {'value': SACRouteUrl.history, 'key': 'Rate And Review'},
    {'value': SACRouteUrl.history, 'key': 'Setting'},
    {'value': SACRouteUrl.logIn, 'key': 'Log In'},
    {'value': SACRouteUrl.history, 'key': 'Log Out'},
    {'value': SACRouteUrl.history, 'key': 'Debug'},
    {'value': SACRouteUrl.history, 'key': '趋避'},
    {'value': SACRouteUrl.history, 'key': 'History'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log Out'),
      ),
      body: ListView.builder(
          itemCount: settingsList.length,
          itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            int kv = index % 2;
            if (kv > 0) {
              return ListTile(
                trailing: Icon(Icons.chevron_right, color: Colors.grey),
                title: Text(settingsList[index]['key']),
                onTap: () {
                  SACNavigator.pushNamed(
                    context,
                    settingsList[index]['value'],
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
                  title: Text(settingsList[index]['key']),
                  onTap: () {
                    SACNavigator.pushNamed(
                      context,
                      settingsList[index]['value'],
                    );
                  },
                ),
              );
            } // End if
          }),
    );
  }
}
