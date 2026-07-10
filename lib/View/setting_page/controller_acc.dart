import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medit_app/View/login_screen/login_screen.dart';
import 'package:medit_app/View/setting_page/setting_function/about_screen/about_page.dart';
import 'package:medit_app/View/setting_page/setting_function/account_screen/account_fun.dart';
import 'package:medit_app/View/setting_page/setting_function/language_screen/language_page.dart';
import 'package:medit_app/View/setting_page/setting_function/notfication_screen/notification_page.dart';
import 'package:medit_app/View/setting_page/setting_function/privacy_screen/privacy_fun.dart';
import 'package:medit_app/View/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerSetting extends GetxController {
  var items = <Map<String, dynamic>>[].obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    items.addAll([
      {
        "text": "Account",
        "icon": Icons.person,
        "navigation": () => Get.to(() => const AccountsFun()),
      },
      {
        "text": "Privacy",
        "icon": Icons.privacy_tip_outlined,
        "navigation": () => Get.to(() => PrivacyFun()),
      },
     /* {
        "text": "Language",
        "icon": Icons.language_outlined,
        "navigation": () => Get.to(() => const LanguagePage()),
      },*/
    /*  {
        "text": "Notification",
        "icon": Icons.notification_add_outlined,
        "navigation": () => Get.to(() => const NotificationPage()),
      },*/
      {
        "text": "About",
        "icon": Icons.supervised_user_circle_outlined,
        "navigation": () => Get.to(() => const AboutPage()),
      },
      {
        "text": "Terms and Condition",
        "icon": Icons.terminal_sharp,
        "navigation": () => Get.to(() => const AccountsFun()),
      },
      {
        "text": "LogOut",
        "icon": Icons.logout_outlined,
        "navigation": () async {
          await logOut();
        },
      },
    ]);
  }

  Future<void> logOut() async {
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool(SplashScreenState.keyLogin, false);

    await _auth.signOut();
    Get.to(LoginScreen());
  }
}
