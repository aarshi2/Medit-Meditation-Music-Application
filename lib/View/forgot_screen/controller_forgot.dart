import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ForgotController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;

  void resetPassword() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    formKey.currentState!.save();
    isLoading.value = true;

    try {
      await _auth.sendPasswordResetEmail(email: emailController.text.trim());
      Get.snackbar(
        '',
        '',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey[850],
        colorText: Colors.white,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 5),
        icon: const Icon(Icons.check_circle, color: Colors.green),
        messageText: const Text(
          "Password Reset Email Sent",
          style: TextStyle(color: Colors.white),
        ),
      );
      Get.back();
    } on FirebaseAuthException catch (err) {
      Get.snackbar(
        '',
        '',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey[850],
        colorText: Colors.white,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 5),
        icon: const Icon(Icons.check_circle, color: Colors.green),
        messageText: const Text(
          "Invalid Email",
          style: TextStyle(color: Colors.white),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
