import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:totalx_assessment/src/core/utils/constants.dart';

import '../../../../../core/utils/result.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  AuthRemoteDataSourceImpl(this.firebaseAuth);

  @override
  Future<Result<String?>> sendOtp(String phoneNumber) async {
       try {
      final Completer<String> completer = Completer();

      await firebaseAuth.verifyPhoneNumber(
        timeout: timeout,
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Handle auto-retrieval of SMS code
          // You can use the credential to sign in here, but consider returning it
          // for later use:
          // return credential;
        },
        verificationFailed: (FirebaseAuthException e) {
          completer.completeError(e);  // Complete the future with an error
        },
        codeSent: (String verificationId, int? resendToken) async {
          print("Verification ID: $verificationId");
          completer.complete(verificationId);  // Complete the future with the verification ID
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle auto-retrieval timeout, you may want to complete with an error or a timeout message
          completer.completeError(Exception("Auto-retrieval timeout"));
        },
      );

      // Await the completion of the future
      final verificationId = await completer.future;

      return Result(StatusCode.success, "", verificationId);
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase auth errors
      print(e.toString());
      return Result(StatusCode.unExpectedError, e.toString(), "");
    } catch (e) {
      return Result(StatusCode.unExpectedError, e.toString(), "");
    }
  
  }

  @override
  Future<Result<bool>> verifyOtp(String verificationId, String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      var userCredential = await firebaseAuth.signInWithCredential(credential);
      return userCredential.user != null
          ? Result(StatusCode.success, "", true)
          : Result(StatusCode.failure, "user not found", false);
    } on FirebaseAuthException catch (e) {
      return Result(StatusCode.unExpectedError, e.message!, true);
    } catch (e) {
      return Result(StatusCode.unExpectedError, "", false);
    }
  }

  @override
  Future<Result<String?>> resendOtp(String phoneNumber) async {
    var result = await sendOtp(phoneNumber);
    return result;
  }
}
