import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medit_app/View/bottom_bar_screen/bottombar.dart';
import 'package:medit_app/View/verify_email_screen/verify_email.dart';

class SignupController extends GetxController {
  final GlobalKey<FormState> form_key1 = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var passwordVisible = false.obs;
  bool isLoading = false;
  late String message;

  // Make playlist observable
  RxList<Map<String, dynamic>> playlist = <Map<String, dynamic>>[].obs;

  // Signup method
  Future<void> signUp() async {
    if (form_key1.currentState!.validate()) {
      form_key1.currentState!.save();
      isLoading = true;
      try {
        await auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        Fluttertoast.showToast(
            msg:"Registration Successful",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white.withOpacity(0.6),
            textColor: Colors.black,
            fontSize: 16.0
        );


        Get.to(const VerifyPage());
        storeData(emailController.text, usernameController.text);
      } on FirebaseAuthException catch (e) {
        if (kDebugMode) {
          print(e);
        }
        Fluttertoast.showToast(
            msg:"Already Registered",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white.withOpacity(0.6),
            textColor: Colors.black,
            fontSize: 16.0
        );


        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white.withOpacity(0.6),
          textColor: Colors.black,
          fontSize: 16.0,
        );
      } finally {
        isLoading = false;
      }
    } else {
      Fluttertoast.showToast(
        msg: "Password does not match",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white.withOpacity(0.6),
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  //google with signup
  Future<void> signInWithGoogle() async {

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User cancelled the sign-in process
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      // Logging user details for debugging purposes
      if (kDebugMode) {
        print("User signed in: ${user?.displayName}, ${user?.email}");
      }

      // Store user data
      await storeData(user?.email ?? '', user?.displayName ?? googleUser.id);

      // Navigate to the login screen or any other screen after successful sign-in
      Get.to(() => const BottomNavBarScreen());
    } on FirebaseAuthException catch (e) {

      Fluttertoast.showToast(
        msg: "Failed to sign in with Google: ${e.message}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }

      Fluttertoast.showToast(
        msg: "An unexpected error occurred: $error",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

    }
  }

  // store data on firestore
  Future<void> storeData(String email, String username) async {
    await firestore.collection('user').doc(auth.currentUser?.uid).set({
      "name": username,
      "email": email,
    });
  }

  // fetch playlist on firestore
  Future<void> fetchPlaylist() async {
    try {
      DocumentSnapshot documentSnapshot =
          await firestore.collection('user').doc(auth.currentUser?.uid).get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        List<dynamic> playlistData = data['playlist'] as List<dynamic>;
        playlist.value = playlistData.cast<Map<String, dynamic>>();
        if (kDebugMode) {
          print(playlist);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching playlist: $e');
      }
    }
  }

  // add song playlist on firestore
  Future<void> addSongToPlaylist(
    String playlistId,
    String title,
    String artist,
    String playlistName,
    String songUrl,
    String songImg,
    String description,
  ) async {
    final firestore = FirebaseFirestore.instance;
    Map<String, dynamic> newSong = {
      playlistName: [
        {
          "songName": title,
          "artist": artist,
          "description": description,
          "songImg": songImg,
          "songUrl": songUrl,
          "playlistId": playlistId,
        }
      ]
    };
    //bool playlistExists = false;
    /*  for (var item in playlist) {
      if (item.containsKey(playlistName)) {
        (item[playlistName] as List).add(newSong);
        playlistExists = true;
        break;
      }
    }

    if (!playlistExists) {
      playlist.add(newSong);
    }*/
    playlist.add(newSong);
    try {
      await firestore
          .collection(
              'user')
          .doc(auth.currentUser?.uid)
          .update({
        'playlist': FieldValue.arrayUnion(playlist),
      });

      Fluttertoast.showToast(
          msg:  "Song added to playlist",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white.withOpacity(0.6),
          textColor: Colors.black,
          fontSize: 16.0
      );


    } catch (e) {

      Fluttertoast.showToast(
          msg:  'Error'
          'Failed to add song: $e',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }
  }


  RxList<Map<String, dynamic>> modelList = <Map<String, dynamic>>[].obs;

  Future<void> playList(String playlistname,index) async {
    try {
      DocumentSnapshot documentSnapshot =
          await firestore.collection('user').doc(auth.currentUser?.uid).get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        List<dynamic> playlistData =
            data['playlist'][index][playlistname] as List<dynamic>;
        modelList.value = playlistData.cast<Map<String, dynamic>>();
        if (kDebugMode) {
          print(modelList);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching playlist: $e');
      }
    }
  }


  Future<void> toPlaylist(
      String playlistId,
      String title,
      String artist,
      String playlistName,
      String songUrl,
      String songImg,
      String description,
      int index // List to store all songs data
      ) async {
    final firestore = FirebaseFirestore.instance;

    try {
      // Construct a map for the new song details
      Map<String, dynamic> newSong = {
        "songName": title,
        "artist": artist,
        "description": description,
        "songImg": songImg,
        "songUrl": songUrl,
        "playlistId": playlistId,
      };
      // Add the new song data to the allSongsData list
      modelList.add(newSong);
      playlist[index][playlistName].add(newSong);
      // Update the playlist document in Firestore with the updated allSongsData list
      await firestore
          .collection(
              'user') // Assuming 'users' is the collection containing user documents
          .doc(auth.currentUser?.uid) // Replace with your actual user ID logic
          .update({'playlist': playlist}).catchError((onError) {
        if (kDebugMode) {
          print("Error is :- $onError");
        }
      });

      // Show success message using Get.snackbar

      Fluttertoast.showToast(
          msg:  "Song added to playlist",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white.withOpacity(0.6),
          textColor: Colors.black,
          fontSize: 16.0
      );

    } catch (e) {
      if (kDebugMode) {
        print("Error is $e");
      }
      // Show error message using Get.snackbar if there's an error

      Fluttertoast.showToast(
          msg:  'Error'
          'Failed to add song: $e',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }
  }
  void showCustomToast(String errorCode) {


    if (errorCode == 'weak-password') {
      message = "The password provided is too weak.";
    } else if (errorCode == 'email-already-in-use') {
      message = "An account already exists for this email.";
    } else {
      message = "Registration failed. Please try again.";
    }


  }

}
