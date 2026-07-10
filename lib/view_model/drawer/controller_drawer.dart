import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:medit_app/view/login_screen/login_screen.dart';

class CustomDrawerController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  final RxString username = ''.obs;

  @override
  void onInit() {
    super.onInit();
    if (_auth.currentUser != null) {
      fetchUsername();
    }
  }

  Future<void> fetchUsername() async {
    try {
      final DocumentSnapshot userDoc = await fireStore.collection('user').doc(_auth.currentUser?.uid).get();
      if (kDebugMode) {
        print('Fetched user document: ${userDoc.data()}');
      } // Debugging print statement
      if (userDoc.exists) {
        username.value = userDoc.get('name');
        if (kDebugMode) {
          print('Username fetched: ${username.value}');
        } // Debugging print statement
      } else {
        username.value = 'Undefined name';
      }
    } catch (e) {
      username.value = 'Undefined name';
      if (kDebugMode) {
        print('Error fetching username: $e');
      } // Debugging print statement
    }
  }


  Future<void> logOut() async {
    await _auth.signOut();
    Get.to(LoginScreen());
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  Future<void> updateUsername(String newUsername) async {
    try {
      await fireStore.collection('user').doc(_auth.currentUser?.uid).update({
        'name': newUsername,
      });
      username.value = newUsername;
    } catch (e) {
      // Handle error
    }
  }
}
