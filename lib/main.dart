import 'package:amirtha_ayurvedha/common/secrets/token.dart';
import 'package:amirtha_ayurvedha/common/theme/themes.dart';
import 'package:amirtha_ayurvedha/features/auth/presentation/pages/login_screen.dart';
import 'package:amirtha_ayurvedha/features/register/controller/registration_screen_provider.dart';
import 'package:amirtha_ayurvedha/features/register/presentation/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/controller/login_provider_controller.dart';
import 'features/home/controller/home_screen_provider_controller.dart';
import 'features/home/presentation/pages/home_screen.dart';
import 'features/splash_screen/presentation/pages/splash_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Secrets.token = prefs.getString('token')!;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => RegistrationScreenProvider()),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}

