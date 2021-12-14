import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:flutter/foundation.dart';

enum ApplicationLoginState {
  loggedIn,
  loggedOut,
  emailAddress,
  password,
  register,
}

const bool USE_FIRE_AUTH_EMULATOR = false;

class SABUserAuthService extends ChangeNotifier {
  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;

  String? _email;
  String? get email => _email;

  String? _displayName;
  String? get displayName => _displayName;

  Future<void> initFireAuth() async {
    if (USE_FIRE_AUTH_EMULATOR) {
      await FirebaseAuth.instance.useAuthEmulator("http://localhost", 9099);
    }
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
        _displayName = user.displayName;
      } else {
        _loginState = ApplicationLoginState.loggedOut;
      }

      notifyListeners();
    });
  }

  void startLoginFlow() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  void verifyEmail(
    String email,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        _loginState = ApplicationLoginState.password;
      } else {
        _loginState = ApplicationLoginState.register;
      }
      _email = email;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signInWithEmailAndPassword(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    FirebaseAuthException? failure;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      failure = e;
    } finally {
      if (null == failure) {
        errorCallback(FirebaseAuthException(message: '成功', code: '0'));
      } else {
        errorCallback(failure);
      }
    }
  }

  void cancelRegistration() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  void registerAccount(String email, String displayName, String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(displayName);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    _displayName = null;
  }

  void sendPasswordResetEmail(String email) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  void verifyPasswordResetCode(String code) {
    FirebaseAuth.instance.verifyPasswordResetCode(code);
  }
}
