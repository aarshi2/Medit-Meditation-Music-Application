import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medit_app/View/whats_new_page/whats_new.dart';
import 'package:medit_app/view/listenhistory_screen/listenhistory_screen/listenhistory_page.dart';
import 'package:medit_app/view/login_screen/login_screen.dart';
import 'package:medit_app/view/profile_screen/profile_page.dart';
import 'package:medit_app/view/setting_page/setting_screen.dart';
import 'package:medit_app/view/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller_drawer.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final customDrawerController = Get.find<CustomDrawerController>();

    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: const Alignment(0.9, 1.5),
                colors: <Color>[
                  Colors.deepPurple.withOpacity(0.7),
                  Colors.black.withOpacity(0.8),
                ],
                tileMode: TileMode.mirror,
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  radius: 30,
                  child: Obx(() {
                    return Text(
                      customDrawerController.username.value.isNotEmpty
                          ? customDrawerController.username.value[0]
                          : 'U',
                      style: const TextStyle(fontSize: 40.0),
                    );
                  }),
                ),
                const SizedBox(width: 16),
                Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customDrawerController.username.value.isNotEmpty
                            ? customDrawerController.username.value
                            : 'Undefined name',
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      // Uncomment if you want to show the greeting message
                      Text(
                        customDrawerController.greeting(),
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),

          ListTile(
            leading: const Icon(Icons.flash_on, color: Colors.white),
            title: const Text("What's new", style: TextStyle(color: Colors.white)),
            onTap: () {
              // Handle What's new tap
              Get.to(WhatsNew());
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title: const Text('View Profile', style: TextStyle(color: Colors.white)),
            onTap: () {
              Get.to(const ProfileScreen()); // Remove const here if needed
            },
          ),
          ListTile(
            leading: const Icon(Icons.history, color: Colors.white),
            title: const Text('Listening history', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Handle Listening history tap
              Get.to(const ListenHistoryPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.white),
            title: const Text('Settings and privacy', style: TextStyle(color: Colors.white)),
            onTap: () {
              Get.to(const SettingPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined, color: Colors.white),
            title: const Text('Logout', style: TextStyle(color: Colors.white)),
            onTap: () async {
              var sharedPref = await SharedPreferences.getInstance();
              sharedPref.setBool(SplashScreenState.keyLogin, false);
              customDrawerController.logOut();
              Get.to(LoginScreen());
            },
          ),
        ],
      ),
    );
  }
}
