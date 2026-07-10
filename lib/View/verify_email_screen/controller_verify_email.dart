import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:medit_app/View/login_screen/login_screen.dart';

class VerifyController extends GetxController {
  var isEmailVerified = false.obs;
  var canResendEmail = false.obs;
  late Timer timer;

  @override
  void onInit() {
    super.onInit();
    isEmailVerified.value = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified.value) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
            (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }

  Future<void> checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    isEmailVerified.value = FirebaseAuth.instance.currentUser!.emailVerified;

    if (isEmailVerified.value) timer.cancel();
  }

  Future<void> sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      canResendEmail.value = false;
      await Future.delayed(const Duration(seconds: 1));
      canResendEmail.value = true;
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    Get.to(LoginScreen());
  }
}
