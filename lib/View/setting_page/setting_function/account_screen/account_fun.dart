import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medit_app/View/profile_screen/edit_profile.dart';
import 'package:medit_app/resources/color.dart';
import 'controller_account.dart';


class AccountsFun extends StatefulWidget {
  const AccountsFun({super.key});

  @override
  State<AccountsFun> createState() => _AccountFunState();
}

class _AccountFunState extends State<AccountsFun> {


  final AccountConroller accountController = Get.put((AccountConroller()));

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: GradientDecoration.getBackground(),

      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          title: const Text("Account",style: TextStyle(color:Colors.white ),),
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          margin: const EdgeInsets.all(10),
          child:   Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Account Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,color:Colors.white ,),
              ),
              const SizedBox(height:30),
              ListTile(
               title: const Text("Username:",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:Colors.white ),),
               subtitle: Padding(
                 padding: const EdgeInsets.only(top: 5),
                 child: Obx(() {
                   return   InkWell(
                     onTap: () async {
                       showModalBottomSheet(
                         context: context,
                         isScrollControlled: true,
                         builder: (context) => const EditProfileBottomSheet(),
                       );
                       await accountController.fetchUsername();
                     },
                     child: Text(
                       accountController.username.value.isNotEmpty
                     ? accountController.username.value
                         : 'Undefined name',
                     style: const TextStyle(fontSize: 18, color: Colors.white),

                     ),
                   );
                   },

                 ),
             ),
             ),
              Container(
                decoration: const BoxDecoration(border: BorderDirectional(bottom: BorderSide(color: Colors.white))),
              ),

              const SizedBox(height: 20,),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Your Plan",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700,color:Colors.white ),
                ),
              ),
              const SizedBox(height:10),
              ListTile(
                leading: Image.asset("asset/img_1.png",)
                ,title: const Text("Free Plan",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color:Colors.white ),),
                subtitle: const Text("View Your Plan ",style: TextStyle(fontWeight: FontWeight.w500,color:Colors.white ),),
              ),

              Container(
                decoration: const BoxDecoration(border: BorderDirectional(bottom: BorderSide(color: Colors.white))),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {

                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "To close your account yourself and delete your data\npermanently,click here.",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Colors.grey),
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
