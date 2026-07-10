import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:medit_app/View/signup_screen/controller_signup.dart';
import 'package:medit_app/modal/fav_modal.dart';

class ControllerFav extends GetxController {
  var favList = <FavModel>[].obs;
  var favStatus = {}.obs; // Map to store favorite status of songs

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final SignupController signupController = Get.put(SignupController());

  @override
  void onInit() {
    super.onInit();
    fetchFavModel();
  }

  Future<void> fetchFavModel() async {
    try {
      DocumentSnapshot documentSnapshot = await firestore
          .collection('user')
          .doc(signupController.auth.currentUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
        documentSnapshot.data() as Map<String, dynamic>;
        List<dynamic>? playlistData =
        data['fav'] as List<dynamic>?;

        if (playlistData != null) {
          var fetchedFav = playlistData
              .map((item) => FavModel.fromJson(item))
              .toList();
          favList.assignAll(fetchedFav);
          // Initialize favStatus map from fetched data
          favStatus.assignAll(Map.fromIterable(favList,
              key: (v) => v.playlistId, value: (v) => true));
        } else {
          // Clear favList and favStatus if no data
          favList.clear();
          favStatus.clear();
        }

        if (kDebugMode) {
          print('Fav List: $favList');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching playlist: $e');
      }
    }
  }

  Future<void> addSongToFav(String playlistId, String title, String artist,
      String songUrl, String songImg, String description) async {
    Map<String, dynamic> fSong = {
      "playlistId": playlistId,
      "songName": title,
      "artist": artist,
      "songUrl": songUrl,
      "songImg": songImg,
      "description": description,
      "isFavorite": true, // Set initial favorite status to true
    };

    try {
      favList.add(FavModel.fromJson(fSong));
      favStatus[playlistId] = true; // Update favStatus for the new song
      await firestore.collection('user').doc(
          signupController.auth.currentUser?.uid).update({
        'fav': favList.map((song) => song.toJson()).toList(),
      });

      Fluttertoast.showToast(
        msg: "Song added to Favourite",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

    } catch (e) {
      if (kDebugMode) {
        print("Error");
      }
    }
  }

  Future<void> removeSongFromFav(String playlistId) async {
    try {
      // Remove the song with the matching playlistId from favList
      favList.removeWhere((song) => song?.playlistId == playlistId);
      favStatus.remove(playlistId); // Remove from favStatus as well

      // Update Firestore with the new list
      await firestore.collection('user').doc(
          signupController.auth.currentUser?.uid).update({
        'fav': favList.map((song) => song.toJson()).toList(),
      });

    } catch (e) {
      if (kDebugMode) {
        print("Failed to remove");
      }
    }
  }

  // Function to toggle favorite status of a song
  void toggleFavorite(String playlistId) {
    if (favStatus.containsKey(playlistId)) {
      favStatus[playlistId] = !favStatus[playlistId];
    } else {
      favStatus[playlistId] = true; // Initialize to true if not found
    }
    update(); // Update UI
  }

  // Function to check if a song is liked
  bool isFavorite(String playlistId) {
    return favStatus.containsKey(playlistId) ? favStatus[playlistId]! : false;
  }
}
