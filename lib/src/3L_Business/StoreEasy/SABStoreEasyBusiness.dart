import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourlucky/src/3L_Business/StoreEasy/SABEasyDigitModel.dart';
import 'package:yourlucky/src/4L_Service/SASFireStoreService.dart';

/// A reference to the list of movies.
/// We are using `withConverter` to ensure that interactions with the collection
/// are type-safe.
final easyRef = FirebaseFirestore.instance
    .collection('easy_digit_model_history')
    .withConverter<SABEasyDigitModel>(
      fromFirestore: (snapshots, _) =>
          SABEasyDigitModel.fromJson(snapshots.data()!),
      toFirestore: (easy, _) => easy.toJson(),
    );

class SABStoreEasyBusiness {
  /// Requires that a Firestore emulator is running locally.
  /// See https://firebase.flutter.dev/docs/firestore/usage#emulator-usage
  Future<void> initFireBase() async {
    await SASFireStoreService.initFireBase();
  }

  void addDigitModel(SABEasyDigitModel digitModel) {
    easyRef.add(digitModel);
  }

  Query<SABEasyDigitModel> getQueryRes() {
    return easyRef.limit(3);
  }
}
