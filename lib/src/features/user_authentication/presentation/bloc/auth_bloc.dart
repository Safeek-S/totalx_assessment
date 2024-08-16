import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totalx_assessment/src/core/utils/result.dart';
import 'package:totalx_assessment/src/core/utils/validators.dart';
import '../../domain/usecases/resend_otp.dart';
import '../../domain/usecases/send_otp.dart';
import '../../domain/usecases/verify_otp.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SendOtp sendOtp;
  final VerifyOtp verifyOtp;
  final ResendOtp resendOtp;
  late Timer _timer;
  int _start = 62;

  AuthBloc({
    required this.sendOtp,
    required this.verifyOtp,
    required this.resendOtp,
  }) : super(AuthInitial()) {
    on<SendOtpEvent>(_handleSendOtpEvent);
    on<VerifyOtpEvent>(_handleVerifyOtpEvent);
    on<ResendOtpEvent>(_handleResendOtpEvent);
    on<StartOtpCountdownEvent>(_onStartOtpCountdown);
  }

  void _handleResendOtpEvent(
      ResendOtpEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());

      final result = await resendOtp(event.phoneNumber);

      if (result.statusCode == StatusCode.unExpectedError) {
        emit(AuthError(message: result.message));
      } else if (result.statusCode == StatusCode.failure) {
        emit(AuthError(message: result.message));
      } else if (result.statusCode == StatusCode.success) {
        emit(OtpSent(
            verificationId: result.data!, phoneNumber: event.phoneNumber));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  void _handleVerifyOtpEvent(
      VerifyOtpEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());

      final result = await verifyOtp(event.verificationId, event.smsCode);
      if (result.statusCode == StatusCode.failure) {
        emit(AuthError(message: result.message));
      } else if (result.statusCode == StatusCode.unExpectedError) {
        emit(AuthError(message: result.message));
      } else if (result.statusCode == StatusCode.success) {
        emit(AuthSuccess());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  void _handleSendOtpEvent(SendOtpEvent event, Emitter<AuthState> emit) async {
    try {
      String phoneNumber = "";
      emit(AuthLoading());
       if (event.phoneNumber.startsWith("+91")) {
      phoneNumber = event.phoneNumber;
    }else{
      phoneNumber = "+91${event.phoneNumber}";
    }
      if (Validators.validatePhoneNumber(phoneNumber)) {
        final result = await sendOtp(phoneNumber);
        if (result.statusCode == StatusCode.unExpectedError) {
          emit(AuthError(message: result.message));
        } else if (result.statusCode == StatusCode.failure) {
          emit(AuthError(message: result.message));
        } else if (result.statusCode == StatusCode.success) {
           _handleSentOtp(); 
          emit(OtpSent(
              verificationId: result.data!, phoneNumber: phoneNumber));
        }
      } else {
        emit(AuthError(
            message: "Invalid phone number,Please check your number"));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
   _handleSentOtp() {
    add(StartOtpCountdownEvent());
   }
  Future<void> _onStartOtpCountdown(StartOtpCountdownEvent event, Emitter<AuthState> emit) async {
  _start = 60;

  while (_start > 0) {
    await Future.delayed(const Duration(seconds: 1));
    _start--;

  
    if (emit.isDone) return;

    emit(OtpCountdownState(_start));
  }
}

}
