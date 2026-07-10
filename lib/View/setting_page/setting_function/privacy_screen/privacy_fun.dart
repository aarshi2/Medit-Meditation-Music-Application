import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medit_app/resources/color.dart';
import 'controller_privacy.dart';

class PrivacyFun extends StatelessWidget {
  PrivacyFun({Key? key}) : super(key: key);

  // Using Get to find the controller instance
  final ControllerPri controller = Get.put(ControllerPri());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: GradientDecoration.getBackground(),
      child: Scaffold(
        // Using Text to write in app bar
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          title: const Padding(
            padding: EdgeInsets.only(left: 95),
            child: Text("Privacy",style: TextStyle(color:Colors.white ),),
          ),
        ),
        backgroundColor: Colors.transparent,
        body:
            //using to scroll screen
        SingleChildScrollView(
          child: Column(
            children: [

              Obx(() => ListTile(
                title: const Text("Followers & Following",style: TextStyle(fontWeight: FontWeight.w500,color:Colors.white )),
                subtitle: const Text(
                  "Show your follower and following lists on your profile",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                trailing: Transform.scale(
                  scale: 1,
                  child: Switch(
                    value: controller.isSwitchedFollowers.value,
                    onChanged: controller.toggleFollowersSwitch,
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey,
                  ),
                ),
              )),
              const SizedBox(height: 20),
              Container(
                decoration: const BoxDecoration(
                  border: BorderDirectional(bottom: BorderSide(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 10),
              Obx(() => ListTile(
                title: const Text("Private session",style: TextStyle(fontWeight: FontWeight.w500,color:Colors.white )),
                subtitle: const Text(
                  "Temporarily hide your listening activity from your followers. Private sessions will automatically end after 6 hours",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                trailing: Transform.scale(
                  scale: 1,
                  child: Switch(
                    value: controller.isSwitchedPrivateSession.value,
                    onChanged: controller.togglePrivateSessionSwitch,
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey,
                  ),
                ),
              )),
              const SizedBox(height: 30),
              Container(
                decoration: const BoxDecoration(
                  border: BorderDirectional(bottom: BorderSide(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 10),
              Obx(() => ListTile(
                title: const Text("Listening activity",style: TextStyle(fontWeight: FontWeight.w500,color:Colors.white ),),
                subtitle: const Text(
                  "Share what I listen to with my followers on Medit",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                trailing: Transform.scale(
                  scale: 1,
                  child: Switch(
                    value: controller.isSwitchedListeningActivity.value,
                    onChanged: controller.toggleListeningActivitySwitch,
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey,
                  ),
                ),
              )),
              const SizedBox(height: 10),
              const ListTile(
                title: Text("Recently played artists",style: TextStyle(fontWeight: FontWeight.w500,color:Colors.white ),),
                subtitle: Text(
                  "Show my recently played artists on my public profile",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
              const ListTile(
                title: Text("Block Users",style: TextStyle(fontWeight: FontWeight.w500,color:Colors.white ),),

                ),


              const SizedBox(height: 10),
              Container(
                decoration: const BoxDecoration(
                  border: BorderDirectional(bottom: BorderSide(color: Colors.white)),
                ),
              ),
              const ListTile(
                title: Text("Jam ",style: TextStyle(fontWeight: FontWeight.w500,color:Colors.white ),),

              ),
              const InkWell(
                child: ListTile(
                  title: Text("Tap and join ",style: TextStyle(fontWeight: FontWeight.w500,color:Colors.white ),),
                  subtitle: Text(
                    "Turn on Bluetooth and bring your phones together together to join the jam",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
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
