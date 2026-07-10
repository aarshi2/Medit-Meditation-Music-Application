import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:medit_app/View/login_screen/login_screen.dart';
import 'package:medit_app/View/signup_screen/controller_signup.dart';
import 'package:medit_app/resources/color.dart';

class SignupScreen extends StatelessWidget {
  final SignupController _signupController = Get.put(SignupController());

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: GradientDecoration.getBackground(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 70),
                const Text(
                  "Welcome To Medit",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 35,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Relax your mind with Medit",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.all(15),
                  child: Form(
                    key: _signupController.form_key1,
                    child: Column(
                      children: [
                        Lottie.asset(
                          height: 300,
                          'asset/Animation - 1714198298188.json',
                          fit: BoxFit.cover,
                        ),
                        TextFormField(
                          controller: _signupController.usernameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Username',
                            hintText: 'Enter your username',
                            labelStyle: const TextStyle(color: Colors.white),
                            hintStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            suffixIcon: const Icon(
                              Icons.person_pin_rounded,
                              color: Colors.white,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a Name.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: _signupController.emailController,
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
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(15)),
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
                            if (!RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$")
                                .hasMatch(value)) {
                              return "Invalid email address.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        Obx(() => TextFormField(

                              obscureText:
                                  !_signupController.passwordVisible.value,
                              controller: _signupController.passwordController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your Password',
                                hintStyle: const TextStyle(color: Colors.white),
                                labelStyle: const TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _signupController.passwordVisible.toggle();
                                  },
                                  icon: Icon(
                                    _signupController.passwordVisible.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter a password.";
                                }
                                if (value.length < 6) {
                                  return "Password must be at least 6 characters long.";
                                }
                                return null;
                              },
                            )),
                        const SizedBox(height: 15),
                        InkWell(
                          onTap: () {
                            _signupController.signUp();
                          },
                          child: Container(
                            height: 55,
                            width: 390,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "You already have an account?",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.to(LoginScreen());
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(color: Colors.deepPurple),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 45,
                              child: Container(
                                height: 0.10,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white)),
                              ),
                            ),
                            const Expanded(
                              flex: 10,
                              child: Center(
                                child: Text(
                                  "OR",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 45,
                              child: Container(
                                height: 0.10,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white)),
                              ),
                            ),
                            const SizedBox(height: 50)
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              _signupController.signInWithGoogle();
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Image(
                                        image: AssetImage(
                                            "asset/icons8-google-48.png")),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "SIGN UP WITH GOOGLE",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
