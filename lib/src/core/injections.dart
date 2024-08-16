import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:totalx_assessment/src/features/users/data/data_sources/image_pick_data_source.dart';
import 'package:totalx_assessment/src/features/users/domain/usecases/get_user_image.dart';

import '../features/user_authentication/data/data_sources/remote/auth_remote_data_source.dart';
import '../features/user_authentication/data/data_sources/remote/auth_remote_data_source_impl.dart';
import '../features/user_authentication/domain/repositories/auth_repository.dart';
import '../features/user_authentication/domain/repositories/auth_repository_impl.dart';
import '../features/user_authentication/domain/usecases/resend_otp.dart';
import '../features/user_authentication/domain/usecases/send_otp.dart';
import '../features/user_authentication/domain/usecases/verify_otp.dart';
import '../features/user_authentication/presentation/bloc/auth_bloc.dart';
import '../features/users/data/data_sources/local/user_local_data_source.dart';
import '../features/users/data/data_sources/local/user_local_data_source_impl.dart';
import '../features/users/domain/repositories/user_repository.dart';
import '../features/users/domain/repositories/user_repository_impl.dart';
import '../features/users/domain/usecases/add_user.dart';
import '../features/users/domain/usecases/get_users.dart';
import '../features/users/presentation/bloc/user_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => FirebaseAuth.instance);
  sl.registerFactory(() => ImagePickerDataSource());
  sl.registerFactory<UserLocalDataSource>(() => UserLocalDataSourceImpl(sl()));
  sl.registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()));
  sl.registerFactory<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerFactory<UserRepository>(() => UserRepositoryImpl(sl()));

  sl.registerFactory(() => SendOtp(sl()));
  sl.registerFactory(() => VerifyOtp(sl()));
  sl.registerFactory(() => ResendOtp(sl()));
  sl.registerFactory(() => GetUsers(sl()));
  sl.registerFactory(() => AddUser(sl()));
  sl.registerFactory(() => GetUserImage(sl()));

  sl.registerFactory(() => AuthBloc(
        sendOtp: sl(),
        verifyOtp: sl(),
        resendOtp: sl(),
      ));
  sl.registerFactory(() => UserBloc(sl(), sl(), sl()));
}
