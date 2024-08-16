import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../features/user_authentication/data/data_sources/remote/auth_remote_data_source.dart';
import '../features/user_authentication/data/data_sources/remote/auth_remote_data_source_impl.dart';
import '../features/user_authentication/domain/repositories/auth_repository.dart';
import '../features/user_authentication/domain/repositories/auth_repository_impl.dart';
import '../features/user_authentication/domain/usecases/resend_otp.dart';
import '../features/user_authentication/domain/usecases/send_otp.dart';
import '../features/user_authentication/domain/usecases/verify_otp.dart';
import '../features/user_authentication/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => FirebaseAuth.instance);

  sl.registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()));
  sl.registerFactory<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerFactory(() => SendOtp(sl()));
  sl.registerFactory(() => VerifyOtp(sl()));
  sl.registerFactory(() => ResendOtp(sl()));

  sl.registerFactory(() => AuthBloc(
        sendOtp: sl(),
        verifyOtp: sl(),
        resendOtp: sl(),
      ));
}
