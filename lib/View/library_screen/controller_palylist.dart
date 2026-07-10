import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:medit_app/View/signup_screen/controller_signup.dart';
import 'package:medit_app/modal/playlist_modal.dart';

class YourPalylist extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final SignupController signupController = Get.put(SignupController());
  var playlistModel = <PlaylistModel>[].obs;
  RxList<Map<String, dynamic>> playlist = <Map<String, dynamic>>[].obs;
  var playlists = <Map<String, dynamic>>[].obs;
  var playlistName = "";
  var songList = "";
  late int indexNumber;

  Future<void> fetchPlaylistModel(String playlistname, int index) async {
    playlistName = playlistname;
    indexNumber = index;
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('user')
          .doc(signupController.auth.currentUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        List<dynamic> playlistData =
            data['playlist'][index][playlistname] as List<dynamic>;

        // Convert each item in playlistData to a PlaylistModel instance
        if (kDebugMode) {
          print(playlistData);
        }
        var fetchedHistory =
            playlistData.map((item) => PlaylistModel.fromJson(item)).toList();

        // Update the observable list
        playlistModel.assignAll(fetchedHistory);
        if (kDebugMode) {
          print(playlistModel);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching playlist: $e');
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchPlaylist();
  }

  Future<void> deleteSongFromPlaylist(String songId) async {
    try {
      DocumentReference userDocRef = FirebaseFirestore.instance
          .collection('user')
          .doc(signupController.auth.currentUser?.uid);

      // Get the current playlist data
      DocumentSnapshot userDoc = await userDocRef.get();
      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        List<dynamic> playlistData =
            data['playlist'][indexNumber][playlistName] as List<dynamic>;

        // Remove the song from the playlist
        playlistData.removeWhere((song) => song['playlistId'] == songId);

        // Update the Firestore document with the modified playlist
        data['playlist'][indexNumber][playlistName] = playlistData;
        await userDocRef.update({'playlist': data['playlist']});

        // Update the observable list
        playlistModel.removeWhere((song) => song.id == songId);

        if (kDebugMode) {
          print('Song deleted successfully');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting song: $e');
      }
    }
  }

  Future<void> deletePlaylist(int index) async {
    try {
      DocumentReference userDocRef = firestore
          .collection('user')
          .doc(signupController.auth.currentUser?.uid);

      // Get the current playlist data
      DocumentSnapshot userDoc = await userDocRef.get();
      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        List<dynamic> playlistData = data['playlist'] as List<dynamic>;

        // Remove the entire playlist at the specified index
        playlistData.removeAt(index);

        // Update the Firestore document with the modified playlist
        await userDocRef.update({
          'playlist': playlistData,
        });

        // Update the observable list
        playlist.removeAt(index);

        if (kDebugMode) {
          print('Playlist deleted successfully');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting playlist: $e');
      }
    }
  }

  Future<void> fetchPlaylist() async {
    try {
      DocumentSnapshot documentSnapshot = await firestore
          .collection('user')
          .doc(signupController.auth.currentUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        List<dynamic> playlistData = data['playlist'] as List<dynamic>;
        playlists.assignAll(playlistData.cast<Map<String, dynamic>>());
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
}
