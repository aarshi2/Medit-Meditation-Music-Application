import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ControllerPlaylist extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController usernameController = TextEditingController();

  final RxString username = ''.obs;
  final RxString email = ''.obs; // Observable variable for email

  @override
  void onInit() {
    super.onInit();
    if (_auth.currentUser != null) {
      fetchUserDetails();
    }
  }

  // Observable list of maps
  var playlist = <Map<String, String>>[
    {
      'title': 'Liked Songs',
      'subtitle': 'Playlist • 19 songs',
      'image': 'https://i1.sndcdn.com/artworks-y6qitUuZoS6y8LQo-5s2pPA-t500x500.jpg', // Replace with actual asset path or network image
    },
    {
      'title': 'DJ',
      'subtitle': 'Playlist • pg',
      'image': 'https://play-lh.googleusercontent.com/ah1TkYnVgz1MX2dgCgyBBLt6Qp6BJGzGMLD4h1z1xFHj7pXysjNhVQPAzizcQmQfrg',
    },
    {
      'title': 'Mothers Day Special',
      'subtitle': 'Playlist • Friday Siiri',
      'image': 'https://i.pinimg.com/236x/3b/a7/ce/3ba7ce57f083e1cbccb3ed5c60ca1966.jpg',
    },
    {
      'title': 'Arijit Singh',
      'subtitle': 'Artist',
      'image': 'https://cdn.siasat.com/wp-content/uploads/2023/10/arijit-singh.jpg',
    },
  ].obs;

  Future<void> fetchUserDetails() async {
    try {
      final DocumentSnapshot userDoc = await firestore.collection('user').doc(_auth.currentUser?.uid).get();
      if (kDebugMode) {
        print('Fetched user document: ${userDoc.data()}');
      } // Debugging print statement
      if (userDoc.exists) {
        username.value = userDoc.get('name');
        email.value = userDoc.get('email');
        if (kDebugMode) {
          print('Username fetched: ${username.value}');
          print('Email fetched: ${email.value}');
        } // Debugging print statements
      } else {
        username.value = 'Undefined name';
        email.value = 'Undefined email';
      }
    } catch (e) {
      username.value = 'Undefined name';
      email.value = 'Undefined email';
      if (kDebugMode) {
        print('Error fetching user details: $e');
      } // Debugging print statement
    }
  }

  Future<void> updateUsername(String newUsername) async {
    try {
      await firestore.collection('user').doc(_auth.currentUser?.uid).update({
        'name': newUsername,
      });
      username.value = newUsername;
    } catch (e) {
      // Handle error
    }
  }

  Future<void> updateEmail(String newEmail) async {
    try {
      await firestore.collection('user').doc(_auth.currentUser?.uid).update({
        'email': newEmail,
      });
      email.value = newEmail;
    } catch (e) {
      // Handle error
    }
  }
}
