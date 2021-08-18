import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourlucky/src/3L_Business/StoreEasy/SABEasyDigitModel.dart';

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

const bool USE_FIRE_STORE_EMULATOR = true;

class SABStoreEasyBusiness {
  /// Requires that a Firestore emulator is running locally.
  /// See https://firebase.flutter.dev/docs/firestore/usage#emulator-usage
  Future<void> initFireStore() async {
    if (USE_FIRE_STORE_EMULATOR) {
      FirebaseFirestore.instance.settings = const Settings(
        host: 'localhost:8080',
        sslEnabled: false,
        persistenceEnabled: false,
      );
    }
  }

  void addDigitModel(SABEasyDigitModel digitModel) {
    easyRef.add(digitModel);
  }

  Query<SABEasyDigitModel> getQueryRes() {
    return easyRef.orderBy('easyDateTime', descending: true);
  }
}
