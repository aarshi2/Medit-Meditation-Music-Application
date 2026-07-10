import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:medit_app/modal/song_modal.dart';

class MyController extends GetxController {
  // Observable list to store the data
  var songModelList = <SongModel>[].obs;

  // Reference to the Firestore collection
  final CollectionReference collectionRef = FirebaseFirestore.instance
      .collection('data')
      .doc('songs')
      .collection('songs_list');

  @override
  void onInit() {
    super.onInit();
    // Fetch data when the controller is initialized
    fetchData();
  }

  void fetchData() async {
    try {
      // Get all documents from the collection
      QuerySnapshot querySnapshot = await collectionRef.get();

      // Convert documents to MyModel instances and add them to the list
      songModelList.value = querySnapshot.docs.map((doc) => SongModel.fromDocumentSnapshot(doc)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
    }
  }
}