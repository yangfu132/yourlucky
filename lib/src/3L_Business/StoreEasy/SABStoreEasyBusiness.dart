// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourlucky/src/3L_Business/StoreEasy/SABEasyDigitModel.dart';

//
// /// A reference to the list of movies.
// /// We are using `withConverter` to ensure that interactions with the collection
// /// are type-safe.
// final easyRef = FirebaseFirestore.instance
//     .collection('easy_digit_model_history')
//     .withConverter<SABEasyDigitModel>(
//       fromFirestore: (snapshots, _) =>
//           SABEasyDigitModel.fromJson(snapshots.data()!),
//       toFirestore: (easy, _) => easy.toJson(),
//     );
//
// const bool USE_FIRE_STORE_EMULATOR = true;
//
class SABStoreEasyBusiness {
  // late Query<SABEasyDigitModel> _easyQuery;
  // Stream<QuerySnapshot<SABEasyDigitModel>>? _easies;

//   /// Requires that a Firestore emulator is running locally.
//   /// See https://firebase.flutter.dev/docs/firestore/usage#emulator-usage
  Future<void> initFireStore() async {
//     if (USE_FIRE_STORE_EMULATOR) {
//       FirebaseFirestore.instance.settings = const Settings(
//         host: 'localhost:8080',
//         sslEnabled: false,
//         persistenceEnabled: false,
//       );
//     }
  }

  Future<void> _updateQuery() async {
    // setState(() {
    //   _easyQuery = SACContext.easyStore().getQueryRes();
    //   _easies = _easyQuery.snapshots();
    // });
  }

  // Widget _buildBody() {
    // if (null == _easies) {
    //   return Text('Waiting');
    // } else {
    //   return StreamBuilder<QuerySnapshot<SABEasyDigitModel>>(
    //     stream: _easies,
    //     builder: (context, snapshot) {
    //       if (snapshot.hasError) {
    //         return Center(
    //           child: Text(snapshot.error.toString()),
    //         );
    //       }
    //
    //       if (!snapshot.hasData) {
    //         return const Center(child: CircularProgressIndicator());
    //       }
    //
    //       final data = snapshot.requireData;
    //       var dataSize = data.size;
    //       if (dataSize > 0) {
    //         return ListView.builder(
    //           itemCount: dataSize,
    //           itemBuilder: (context, index) {
    //             SABEasyDigitModel digitModel = data.docs[index].data();
    //             return SAUListTitleVisitor.greyWhite(
    //               index,
    //               digitModel.stringTitle,
    //               () {
    //                 SABEasyDetailBusiness detailBusiness =
    //                     SABEasyDetailBusiness(digitModel);
    //                 Navigator.push(context,
    //                     MaterialPageRoute(builder: (context) {
    //                   return SAUEasyDetailRoute(
    //                       detailBusiness.outputDetailModel());
    //                 }));
    //               },
    //             );
    //           },
    //         );
    //       } else {
    //         return Text('No Data');
    //       }
    //     },
    //   );
    // }
  // }

  void addDigitModel(SABEasyDigitModel digitModel) {
    // easyRef.add(digitModel);
  }
//
//   Query<SABEasyDigitModel> getQueryRes() {
//     return easyRef.orderBy('easyDateTime', descending: true);
//   }
}
