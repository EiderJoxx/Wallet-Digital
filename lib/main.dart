import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testapp/presentation/screens/login/Login_Screen.dart';

import 'presentation/screens/home/home_screen.dart';
import 'presentation/screens/login/registrer_Screen.dart';
import 'presentation/screens/login/forgot_password_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet Digital',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF05CEA8),
          primary: const Color(0xFF05CEA8),
          secondary: const Color(0xFF45AA96),
          surface: const Color.fromARGB(255, 0, 0, 0),
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/register': (context) => const RegisterScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
      },
    );
  }
}
