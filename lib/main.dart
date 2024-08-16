import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:totalx_assessment/src/core/injections.dart';

import 'src/app.dart';
import 'src/features/user_authentication/presentation/bloc/auth_bloc.dart';
import 'src/features/users/presentation/bloc/user_bloc.dart';
import 'src/features/users/presentation/bloc/user_event.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyBOPrhFH7tlme2HWorwbNer0OgU4pfzJsE',
              appId: "1:175157767259:android:cd6de108e6a4668bdf237e",
              messagingSenderId: '175157767259',
              projectId: "assessment-977fa"))
      : await Firebase.initializeApp();
  await init();
  runApp(MultiBlocProvider(
   providers: [
           BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>(),
        ),
          BlocProvider<UserBloc>(
          create: (_) => sl<UserBloc>()..add(GetUsersEvent(offset: 0, limit: 10)),
        ),
   ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'User App',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xff100E09)),
            useMaterial3: true,
          ),
          home: const App(),
        );
      },
    );
  }
}
