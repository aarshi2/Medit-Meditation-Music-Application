import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:medit_app/View/explore_screen/categories_screen/inspiration/inspiration_playlist.dart';
import 'package:medit_app/View/explore_screen/categories_screen/nature/nature_playlist.dart';
import 'package:medit_app/View/explore_screen/categories_screen/relaxing/relax_playlist.dart';
import 'package:medit_app/View/explore_screen/categories_screen/spiritual/spiritual_playlist.dart';
import 'package:medit_app/modal/fav_modal.dart';
import 'package:medit_app/modal/search_modal.dart';
import 'package:medit_app/modal/song_modal.dart';

import '../signup_screen/controller_signup.dart';

class ControllerLibrary extends GetxController {
  final SignupController signupController = Get.put(SignupController());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var playListUser;

  var songs = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  @override
  void onInit() {
    super.onInit();
    fetchData();
    fetchSongsFromPlaylist();
    if (_auth.currentUser != null) {
      fetchSongsFromPlaylist();
    }
  }

  Future<void> fetchSongsFromPlaylist() async {
    try {
      isLoading.value = true;
      QuerySnapshot querySnapshot = await _firestore
          .collection('user')
          .doc(_auth.currentUser?.uid)
          .collection('playlists')
          .get();
      playListUser =  _auth.currentUser?.uid;

      songs.value = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Failed to fetch songs: $e';
      if (kDebugMode) {
        print("Error");
      }

    }
  }

  var palyModelList = <SpiritualModal>[].obs;

// Reference to the Firestore collection
  final CollectionReference collectionRef = FirebaseFirestore.instance
      .collection('data')
      .doc('playlist')
      .collection('relaxing');


  void fetchData() async {
    try {
      // Get all documents from the collection
      QuerySnapshot querySnapshot = await collectionRef.get();

      // Convert documents to MyModel instances and add them to the list
      palyModelList.value = querySnapshot.docs.map((doc) => SpiritualModal.fromDocumentSnapshot(doc)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
    }
  }

  var playlist = [
    Categories(name: "Relaxing", image:"asset/img_4.png",page:  const RelaxPlaylist()),
    Categories(name: "Spiritual", image: "asset/spiritual.jpeg",page:  const SpiritualPlaylist()),
    Categories(name: "Nature", image: "asset/img_3.png",page:  const NaturePlaylist()),
    Categories(name: "Inspiration", image: "asset/inspiration.jpeg",page:  const InspirationPlaylist()),
  ].obs;

}
