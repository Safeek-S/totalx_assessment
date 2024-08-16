import '../../../../core/utils/result.dart';
import '../repositories/auth_repository.dart';

class ResendOtp {
  final AuthRepository repository;

  ResendOtp(this.repository);

  Future<Result<String?>> call(String phoneNumber) async {
    return await repository.resendOtp(phoneNumber);
  }
}
