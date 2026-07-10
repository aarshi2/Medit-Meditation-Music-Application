import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:medit_app/view/bottom_bar_screen/bottombar.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  final TextEditingController logEmailController = TextEditingController();
  final TextEditingController logPasswordController = TextEditingController();
  bool isLoading = false;

  var passwordVisible = false.obs;
  bool get isEmailValid => EmailValidator.validate(logEmailController.text);

  void logIn() async {
    if (formKey2.currentState!.validate()) {
      formKey2.currentState!.save();

        isLoading = true ;

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: logEmailController.text.trim(),
            password: logPasswordController.text.trim());
        Fluttertoast.showToast(
            msg:"Login successful",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );

        Get.to(const BottomNavBarScreen());

      } on FirebaseAuthException catch (e) {
         isLoading = false;

        if (e.code == 'user-not-found') {

          Fluttertoast.showToast(
              msg:  "No user found for that email",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white.withOpacity(0.5),
              textColor: Colors.black,
              fontSize: 16.0
          );

        } else if (e.code == 'wrong-password') {

          Fluttertoast.showToast(
              msg: "Wrong password "
                  "provided.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white.withOpacity(0.5),
              textColor: Colors.black,
              fontSize: 16.0
          );
        } else {
          Fluttertoast.showToast(
              msg:  "Username or Password is incorrect",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white.withOpacity(0.5),
              textColor: Colors.black,
              fontSize: 16.0
          );

        }
      }
    }
  }
}
