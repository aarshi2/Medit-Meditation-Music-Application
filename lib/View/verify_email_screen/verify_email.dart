import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medit_app/resources/color.dart';
import 'package:medit_app/view/bottom_bar_screen/bottombar.dart';
import 'controller_verify_email.dart';


class VerifyPage extends StatelessWidget {
  const VerifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final VerifyController controller = Get.put(VerifyController());

    return Obx(() => controller.isEmailVerified.value
        ? const BottomNavBarScreen()
        : Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: GradientDecoration.getBackground(),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Verify Email",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w500),),
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: const Text(
                  "A Verification email has been sent to your email.",
                  style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: InkWell(
                  onTap: controller.canResendEmail.value ? controller.sendVerificationEmail : null,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Resend Email",
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: InkWell(
                  onTap: controller.signOut,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
