import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AccountConroller extends GetxController{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final RxString username =''.obs;
  @override
  void onInit() {
    super.onInit();
    if (_auth.currentUser != null) {
      fetchUsername();
    }
  }

  Future<void> fetchUsername() async {
    try {
      final DocumentSnapshot userDoc = await firestore.collection('user').doc(_auth.currentUser?.uid).get();
      print('Fetched user document: ${userDoc.data()}'); // Debugging print statement
      if (userDoc.exists) {
        username.value = userDoc.get('name');
        print('Username fetched: ${username.value}'); // Debugging print statement
      } else {
        username.value = 'Undefined name';
      }
    } catch (e) {
      username.value = 'Undefined name';
      print('Error fetching username: $e'); // Debugging print statement
    }
  }
}