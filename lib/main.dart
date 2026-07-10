import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:medit_app/View/music_player/controller_player.dart';
import 'package:medit_app/View/profile_screen/controller_profile.dart';
import 'package:medit_app/View/splash_page.dart';

import 'resources/color.dart';
import 'view_model/drawer/controller_drawer.dart';
import 'view_model/firebase_auth/firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio '
        'playback',
    androidNotificationOngoing: true,
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize controllers
  Get.put(
      CustomDrawerController()); // Initialize your CustomDrawerController here
  Get.put(ControllerPlaylist());

  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final PlayerController playerController = Get.put(PlayerController());

  @override
  void initState() {
    super.initState();
    // Adding the observer to listen for app lifecycle changes
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Removing the observer when the widget is disposed
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // Handling different app lifecycle states
    if (state == AppLifecycleState.detached) {
      // Call the function to stop or pause the music when app is in background or about to be terminated
      stopMusic();
    }
  }

  void stopMusic() {
    playerController.player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define a common brightness value for both light and dark themes
    const Brightness brightness = Brightness.light;
    const Brightness darkBrightness = Brightness.dark;

    return GetMaterialApp(
      theme: ThemeData(
        brightness: brightness,
        primaryColor: forestGreen,
        textTheme: const TextTheme(
          titleMedium: TextStyle(color: Colors.white),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          brightness: brightness,
        ),
      ),
      darkTheme: ThemeData(
        brightness: darkBrightness,
        primaryColor: Colors.deepPurple,
        textTheme: const TextTheme(
          titleMedium: TextStyle(color: Colors.white),
        ),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          brightness: darkBrightness,
          secondary: Colors.deepPurpleAccent,
        ),
      ),
      themeMode: ThemeMode.dark,
      // Set dark theme as default
      debugShowCheckedModeBanner: false,

      home: const SplashScreen(),
    );
  }
}
