

import 'package:totalx_assessment/src/core/utils/result.dart';

import '../repositories/auth_repository.dart';

class SendOtp {
  final AuthRepository repository;

  SendOtp(this.repository);

  Future<Result<String?>> call(String phoneNumber) async {
    return await repository.sendOtp(phoneNumber);
  }
}
