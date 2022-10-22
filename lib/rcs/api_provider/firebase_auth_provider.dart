import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterExample/rcs/bloc/auth_bloc.dart';
import 'package:flutterExample/rcs/manager/prefs_manager.dart';

class FirebaseAuthProvider {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final PrefsManager _prefsManager = PrefsManager();

  //Phone number auth
  Future verifyMobileNumberWithOTP(
      AuthBloc authBloc, String countryCode, String phoneNumber) async {
    await auth.verifyPhoneNumber(
      phoneNumber: countryCode + phoneNumber,
      timeout: const Duration(seconds: 0),
      verificationCompleted: _onVerificationCompleted,
      verificationFailed: (FirebaseAuthException exception) {
        if (exception.code == 'invalid-phone-number') {
          authBloc.setException(exception.message ?? '');
        }
        authBloc.setException(exception.message ?? '');
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        _prefsManager.setVerificationId(verificationId.toString());
        authBloc.setException('');
      },
      codeAutoRetrievalTimeout: _onCodeTimeout,
    );
  }

  Future _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    User? user = auth.currentUser;
    if (authCredential.smsCode != null) {
      try {
        await user!.linkWithCredential(authCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'provider-already-linked') {
          await auth.signInWithCredential(authCredential);
        }
      }
    }
  }

  Future _onCodeTimeout(String timeout) async {
    return null;
  }

  Future<AuthCredential> submitOTP(
      {required String otp, required String verificationId}) async {
    String smsCode = otp.toString().trim();

    final AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    return phoneAuthCredential;
  }


  Future<User> getCurrentUser() async {
    return auth.currentUser!;
  }

}
