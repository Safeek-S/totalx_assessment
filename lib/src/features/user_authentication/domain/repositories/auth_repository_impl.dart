import 'package:totalx_assessment/src/core/network/network.dart';

import '../../../../core/utils/result.dart';
import '../../data/data_sources/remote/auth_remote_data_source.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<String?>> sendOtp(String phoneNumber) async {
    try {
      if (await NetworkConnectivity.isConnected()) {
        var result = await remoteDataSource.sendOtp(phoneNumber);
        return result;
      } else {
        return Result(StatusCode.unExpectedError, 'No internet connection', "");
      }
    } catch (e) {
      return Result(StatusCode.unExpectedError, e.toString(), "");
    }
  }

  @override
  Future<Result<bool>> verifyOtp(String verificationId, String smsCode) async {
    try {
      if (await NetworkConnectivity.isConnected()) {
      } else {
        return Result(
            StatusCode.unExpectedError, "No internet connection", false);
      }
      var result = await remoteDataSource.verifyOtp(verificationId, smsCode);
      return result;
    } catch (e) {
      return Result(StatusCode.unExpectedError, e.toString(), false);
    }
  }

  @override
  Future<Result<String?>> resendOtp(String phoneNumber) async {
    try {
      if (await NetworkConnectivity.isConnected()) {
        var result = await remoteDataSource.resendOtp(phoneNumber);
        return result;
      } else {
        return Result(StatusCode.unExpectedError, 'No internet connection', "");
      }
    } catch (e) {
      return Result(StatusCode.unExpectedError, e.toString(), "");
    }
  }
}
