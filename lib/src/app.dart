import 'package:flutter/material.dart';
import 'package:totalx_assessment/src/features/user_authentication/presentation/pages/login_page.dart';
import 'package:totalx_assessment/src/features/user_authentication/presentation/pages/otp_page.dart';
import 'package:totalx_assessment/src/features/users/presentation/pages/user_dashboard_page.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/otp': (context) => OtpPage(),
        '/dashboard': (context) => const UserDashboardPage(),
      },
    );
  }
}
