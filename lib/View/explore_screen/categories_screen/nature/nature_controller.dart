import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:medit_app/modal/song_modal.dart';

class NatureController extends GetxController {
// Observable list to store the data
  var palyModelList = <NatureModal>[].obs;

// Reference to the Firestore collection
  final CollectionReference collectionRef = FirebaseFirestore.instance
      .collection('data')
      .doc('playlist')
      .collection('nature');

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
      palyModelList.value = querySnapshot.docs.map((doc) => NatureModal.fromDocumentSnapshot(doc)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
    }
  }
}
