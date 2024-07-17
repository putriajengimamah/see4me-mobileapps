import 'package:flutter/material.dart';
import 'package:project_see4me/pages/landingpage/landing_page.dart';
import 'package:project_see4me/pages/mainpage/main_page.dart';
import 'package:project_see4me/provider/database_notifier.dart';
import 'package:project_see4me/utils/routers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('assets/images/logo-see4me.png'),
          width: 200,
          height: 200,
        ),
      ),
    );
  }

  navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      DatabaseProvider().getToken().then((value) {
        if (value == '') {
          print(value);
          PageNavigator(ctx: context).nextPage(page: LandingPage());
        } else {
          print(value);
          PageNavigator(ctx: context).nextPage(page: MainSee4MePage());
        }
      });
    });
  }
}
