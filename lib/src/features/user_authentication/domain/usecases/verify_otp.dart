import '../../../../core/utils/result.dart';
import '../repositories/auth_repository.dart';

class VerifyOtp {

  final AuthRepository repository;

  VerifyOtp(this.repository);

  Future<Result<bool>> call(String verificationId, String smsCode) async {
    return await repository.verifyOtp(verificationId, smsCode);
  }
}
