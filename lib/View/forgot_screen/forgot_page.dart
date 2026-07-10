import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medit_app/resources/color.dart';
import 'controller_forgot.dart';

class ForgotPage extends StatelessWidget {
  final ForgotController controller = Get.put(ForgotController());

  ForgotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: GradientDecoration.getBackground(),

        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Forgot Password",style: TextStyle(fontSize: 25, color: Colors.white,fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,),
              const Text(
                "Receive an email to \nreset your password",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400,color: Colors.white),
                textAlign: TextAlign.center,

              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your Email',
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                    suffixIcon: const Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter an email address.";
                    }
                    if (!RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value)) {
                      return "Invalid email address.";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(
                      () => InkWell(
                    onTap: () {
                      if (!controller.isLoading.value) {
                        controller.resetPassword();
                      }
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          controller.isLoading.value
                              ? "Processing..."
                              : "Reset Password",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
