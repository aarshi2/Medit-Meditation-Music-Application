import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medit_app/view_model/firebase_auth/forget_email.dart';

class Forget_phone extends StatefulWidget {
  const Forget_phone({super.key});

  @override
  State<Forget_phone> createState() => _Forget_phoneState();
}

class _Forget_phoneState extends State<Forget_phone> {
  final TextEditingController ForgetNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Text(
                "Welcome To Medit",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Colors.black),
              ),
              Text(
                "Relax your mind with Medit",
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
              Container(
                alignment: Alignment.center,
                height: 300,
                child: Lottie.asset('asset/Animation - 1714198298188.json',
                    fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: ForgetNumber,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'PhoneNumber',
                    hintText: 'Enter your PhoneNumber',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: Icon(
                      Icons.person_pin_rounded,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 45,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    "FORGET",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Forget password Using Email?"),
              TextButton(
                  onPressed: () {

                  },
                  child: Text("Forget password?")),
            ],
          ),
        ),
      ),
    );
  }
}
