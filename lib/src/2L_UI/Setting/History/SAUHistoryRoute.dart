import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yourlucky/src/1L_Context/SACContext.dart';
import 'package:yourlucky/src/2L_UI/Base/SAUListTitleVistor.dart';
import 'package:yourlucky/src/2L_UI/EasyDetail/SAUEasyDetailRoute.dart';
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
  late Query<SABEasyDigitModel> _easyQuery;
  Stream<QuerySnapshot<SABEasyDigitModel>>? _easies;

  @override
  void initState() {
    super.initState();
    _updateQuery();
  }

  Future<void> _updateQuery() async {
    setState(() {
      _easyQuery = SACContext.easyStore().getQueryRes();
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
                SABEasyDigitModel digitModel = data.docs[index].data();
                return SAUListTitleVisitor.greyWhite(
                  index,
                  digitModel.stringTitle,
                  () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SAUEasyDetailRoute(digitModel);
                    }));
                  },
                );
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
