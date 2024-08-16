import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totalx_assessment/src/features/user_authentication/presentation/pages/login_page.dart';
import 'package:totalx_assessment/src/features/user_authentication/presentation/pages/otp_page.dart';

import 'core/injections.dart';
import 'features/user_authentication/presentation/bloc/auth_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
         
          '/': (context) => LoginPage(),
          '/otp': (context) => OtpPage(),
        },
      ),
    );
  }
}
