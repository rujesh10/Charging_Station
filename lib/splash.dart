import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_nist/bottomnav.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    super.initState();

    navigateToOtherPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/splash.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Image.asset(
                  "assets/images/evlogo.png",
                  height: 250,
                  width: 200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  navigateToOtherPage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool('isLogin') ?? false;
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) =>
              isLogin ? const BottomNavigation() : const Start(),
        ),
        (Route<dynamic> route) => false,
      );
    });
  }
}
