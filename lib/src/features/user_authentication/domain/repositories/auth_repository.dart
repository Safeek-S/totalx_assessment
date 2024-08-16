import '../../../../core/utils/result.dart';

abstract class AuthRepository {
  Future<Result<String?>> sendOtp(String phoneNumber);
  Future<Result<bool>> verifyOtp(String verificationId, String smsCode);
  Future<Result<String?>> resendOtp(String phoneNumber);
}
