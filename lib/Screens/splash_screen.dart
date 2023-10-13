// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_pad/Screens/home_screen.dart';
import 'package:travel_pad/Screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkLogin() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final isUserLoggedIn = preferences.getString('user');
    if (isUserLoggedIn == 'LoggedIn') {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const OnboardingScreen(),
          ),
          (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => checkLogin());
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('lib/assets/Hodophile-2.jpg'),
              minRadius: 70,
              maxRadius: 70,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Travel Pad',
              style: TextStyle(fontSize: 45, fontWeight: FontWeight.w200),
            )
          ],
        ),
      ),
    ));
  }
}
