import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sodakkuapp/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    String? phone = prefs.getString('phone');
    bool? isLoggedIn = prefs.getBool('isLoggedIn');
    userId = userid ?? "";
    phoneNumber = phone ?? "";
    isLoggedInvalue = isLoggedIn ?? false;
    debugPrint(
      'UserId: $userId, Phone Number: $phoneNumber, Logged In: $isLoggedInvalue',
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () async {
      await getData();
      if (!mounted) return;
      if (isLoggedInvalue == true) {
        Navigator.pushNamed(context, '/home');
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: secondAppColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 260,
                    height: 259,
                    decoration: BoxDecoration(
                      color: secondAppColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Image.asset(
                  appLogo,
                  //  width: 249,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            SizedBox(height: 50),
            CircularProgressIndicator(
              color: appColor,
              backgroundColor: whitecolor,
            ),
          ],
        ),
      ),
    );
  }
}
