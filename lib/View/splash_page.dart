import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medit_app/view/signup_screen/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottom_bar_screen/bottombar.dart';
import 'login_screen/login_screen.dart';
import 'package:medit_app/resources/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String keyLogin = "login";

  @override
  void initState() {
    super.initState();
    whereToGo();
  }

  whereToGo() async {

    var sharedPref =  await SharedPreferences.getInstance();
    var isLoggedIn =  sharedPref.getBool(keyLogin);

    Timer(
        const Duration(seconds: 5),
            () {
          if(isLoggedIn!=null){
            if(isLoggedIn){
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) =>  BottomNavBarScreen()));
            }else{
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => LoginScreen()));
            }
          }else{
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => SignupScreen()));
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: GradientDecoration.getBackground(),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Welcome To Medit",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Colors.white,
              ),
            ),
            const Text(
              "Relax your mind with Medit",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            SizedBox(
              height: 500,
              child: Lottie.asset("asset/Animation - 1714198298188.json"),
            ),
          ],
        ),
      ),
    );
  }
}