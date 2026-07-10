import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:medit_app/View/signup_screen/controller_signup.dart';
import 'package:medit_app/modal/history_model.dart';

class ListenHistory extends GetxController {
  var historyList = <HistoryModel>[].obs;
  final SignupController signupController = Get.put(SignupController());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchHistoryModel();
  }

  Future<void> fetchHistoryModel() async {
    try {
      DocumentSnapshot documentSnapshot = await firestore
          .collection('user')
          .doc(signupController.auth.currentUser?.uid)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('history')) {
          List<dynamic> playlistData = data['history'] as List<dynamic>;

          // Convert each item in playlistData to a HistoryModel instance
          var fetchedHistory = playlistData.map((item) {
            Map<String, dynamic> itemMap = item as Map<String, dynamic>;
            return HistoryModel.fromJson(itemMap);
          }).toList().reversed;

          // Update the observable list
          historyList.assignAll(fetchedHistory);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching playlist: $e');
      }
    }
  }

  Future<void> addSongToHistory(String playlistId, String title, String artist,
      String songUrl, String songImg, String description) async {
    Map<String, dynamic> historySong = {
      "songName": title,
      "artist": artist,
      "description": description,
      "songImg": songImg,
      "songUrl": songUrl,
      "playlistId": playlistId,
      "date": Timestamp.now(), // Add date when the song is added to history
    };

    try {
      DocumentSnapshot documentSnapshot = await firestore
          .collection('user')
          .doc(signupController.auth.currentUser?.uid)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('history')) {
          List<dynamic> existingHistory = data['history'] as List<dynamic>;
          existingHistory.add(historySong);

          await firestore
              .collection('user')
              .doc(signupController.auth.currentUser?.uid)
              .update({'history': existingHistory});

          // Update the local history list
          fetchHistoryModel();
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }
}
