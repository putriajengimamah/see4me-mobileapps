import 'package:flutter/material.dart';
import 'package:project_see4me/pages/splashpage/splash_page.dart';
import 'package:project_see4me/provider/login_notifier.dart';
import 'package:project_see4me/provider/register_notifier.dart';
import 'package:project_see4me/provider/profile_notifier.dart';
import 'package:provider/provider.dart';
import 'pages/landingpage/landing_page.dart';
import 'pages/resetpasswordpage/resetpassword_page.dart';
import 'pages/profilepage/profile_page.dart';
import 'pages/mainpage/main_page.dart';
import 'pages/forgotpasswordpage/forgot_password_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginNotifier()),
        ChangeNotifierProvider(create: (_) => RegisterNotifier()),
        ChangeNotifierProvider(create: (_) => ProfileNotifier()),
      ],
      child: MaterialApp(
        title: 'Flutter Capstone',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        // home: const ProfilePage(),
        // home: const MainSee4MePage(),
        // home: const ForgotPasswordPage(),
        // home: const ResetPasswordPage(email: "test@example.com"), // Tambahkan argumen email disini
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
