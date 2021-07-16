import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yourlucky/src/1L_Context/SACRouteUrl.dart';
import 'package:yourlucky/src/2L_UI/Base/SAUListTitleVistor.dart';
import 'package:yourlucky/src/3L_Business/StoreEasy/SABEasyDigitModel.dart';

class SAUHistoryRoute extends StatefulWidget {
  SAUHistoryRoute({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  SAUHistoryRouteState createState() {
    return SAUHistoryRouteState();
  }
}

class SAUHistoryRouteState extends State<SAUHistoryRoute> {
  List settingsList = <Map>[
    {'value': SACRouteUrl.history, 'key': 'Feedback'},
    {'value': SACRouteUrl.history, 'key': 'Develop Task'},
    {'value': SACRouteUrl.history, 'key': 'Friends'},
    {'value': SACRouteUrl.history, 'key': 'About'},
    {'value': SACRouteUrl.history, 'key': 'Rate And Review'},
    {'value': SACRouteUrl.history, 'key': 'Setting'},
    {'value': SACRouteUrl.history, 'key': 'Log In'},
    {'value': SACRouteUrl.history, 'key': 'Log Out'},
    {'value': SACRouteUrl.history, 'key': 'Debug'},
    {'value': SACRouteUrl.history, 'key': '趋避'},
    {'value': SACRouteUrl.history, 'key': 'History'},
  ];

  late Query<SABEasyDigitModel> _moviesQuery;
  late Stream<QuerySnapshot<SABEasyDigitModel>> _movies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('历史'),
      ),
      body: StreamBuilder<QuerySnapshot<SABEasyDigitModel>>(
        stream: _movies,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.requireData;

          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              return SAUListTitleVisitor.greyWhite(index, 'title', () {});
              // return _MovieItem(
              //   data.docs[index].data(),
              //   data.docs[index].reference,
              // );
            },
          );
        },
      ),
    );
  }
}
