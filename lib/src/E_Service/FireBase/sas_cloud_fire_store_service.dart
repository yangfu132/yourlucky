import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';

import '../../A_Context/sac_context.dart';

class SASCloudFireStoreService {
  // 初始化 Cloud FireStore 的实例：
  late final FirebaseFirestore db = FirebaseFirestore.instance;
  late final easyCollectionRef = db.collection("easy");
  late final easyDocRef = easyCollectionRef.doc("something");

  void addModel(String collectionName,SABBaseModel model, VoidCallback finishBlock) {
    db.collection(collectionName).add(model.toJson()).then((DocumentReference doc) {
      coPrint('DocumentSnapshot added with ID: ${doc.id}');
      model.cloudId = doc.id;
      finishBlock();
    });
  }

  void addJson(String collectionName,Map<String, dynamic> data, VoidCallback finishBlock) {
    db.collection(collectionName).add(data).then((DocumentReference doc) {
      coPrint('DocumentSnapshot added with ID: ${doc.id}');
      finishBlock();
    });
  }

  void removeModel(String collectionName,SABBaseModel model, VoidCallback finishBlock){
    db.collection(collectionName).doc(model.cloudId).delete();
  }

  Future<void> queryCollection(String collectionName ) async {
    // 您也可以使用“get”方法来检索整个集合。
    await db.collection(collectionName).get().then((event) {
      for (var doc in event.docs) {
        coPrint("${doc.id} => ${doc.data()}");
      }
    });
  }

  Future<void> demo () async {
    addUser1();
    addUser2();

    // 您也可以使用“get”方法来检索整个集合。
    await db.collection("users").get().then((event) {
      for (var doc in event.docs) {
        coPrint("${doc.id} => ${doc.data()}");
      }
    });
  }

  void addUser1() {
    // Create a new user with a first and last name
    final user = <String, dynamic>{
      "first": "Ada",
      "last": "Lovelace",
      "born": 1815
    };

    // Add a new document with a generated ID
    // 使用以下示例代码创建一个新集合和一个新文档。
    db.collection("users").add(user).then((DocumentReference doc) =>
        coPrint('DocumentSnapshot added with ID: ${doc.id}'));
  }
  void addUser2 () {
    // Create a new user with a first and last name
    final user = <String, dynamic>{
      "first": "Alan",
      "middle": "Mathison",
      "last": "Turing",
      "born": 1912
    };

// Add a new document with a generated ID
    db.collection("users").add(user).then((DocumentReference doc) =>
        coPrint('DocumentSnapshot added with ID: ${doc.id}'));
  }
}