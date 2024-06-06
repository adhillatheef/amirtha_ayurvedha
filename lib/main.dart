import 'package:amirtha_ayurvedha/common/theme/themes.dart';
import 'package:amirtha_ayurvedha/features/auth/presentation/pages/login_screen.dart';
import 'package:amirtha_ayurvedha/features/register/presentation/register_screen.dart';
import 'package:flutter/material.dart';

import 'features/home/presentation/pages/home_screen.dart';
import 'features/splash_screen/presentation/pages/splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/LoginScreen': (context) => const LoginScreen(),
        '/HomeScreen' : (context) => const HomeScreen(),
        '/RegisterScreen' : (context) => const RegisterScreen(),
      },
      //home: const SplashScreen(),
    );
  }
}

