import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yourlucky/src/1L_Context/SACContext.dart';
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

  late Query<SABEasyDigitModel> _easyQuery;
  Stream<QuerySnapshot<SABEasyDigitModel>>? _easies;

  @override
  void initState() {
    super.initState();
    _updateQuery();
  }

  Future<void> _updateQuery() async {
    setState(() {
      _easyQuery = SACContext.getStoreBusiness().getQuery();
      _easies = _easyQuery.snapshots();
    });
  }

  Widget _buildBody() {
    if (null == _easies) {
      return Text('Waiting');
    } else {
      return StreamBuilder<QuerySnapshot<SABEasyDigitModel>>(
        stream: _easies,
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
          var dataSize = data.size;
          if (dataSize > 0) {
            return ListView.builder(
              itemCount: dataSize,
              itemBuilder: (context, index) {
                return SAUListTitleVisitor.greyWhite(index, 'title', () {});
              },
            );
          } else {
            return Text('No Data');
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('历史'),
      ),
      body: _buildBody(),
    );
  }
}
