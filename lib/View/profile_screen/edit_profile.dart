import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medit_app/View/profile_screen/controller_profile.dart';

class EditProfileBottomSheet extends StatelessWidget {
  const EditProfileBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ControllerPlaylist listController = Get.put(ControllerPlaylist());

    return DraggableScrollableSheet(
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return  Container(
          height: double.maxFinite,
          width: double.maxFinite,
        //  decoration:GradientDecoration.getBackground(),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.deepPurple,
                  Colors.black,
                ],
                tileMode: TileMode.mirror,
              ),
            ),
          padding: const EdgeInsets.all(16),
          child: ListView(
            controller: scrollController,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      // Save logic here
                      if (listController.usernameController.text.isNotEmpty) {
                        await listController.updateUsername(listController.usernameController.text);
                        Get.back();
                      }
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Obx(() {
                return CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.black38,
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          listController.username.value.isNotEmpty
                              ? listController.username.value[0]
                              : 'U',
                          style: const TextStyle(fontSize: 40, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 16),
              ListTile(
                title: const Text(
                  "Name :-",
                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
                ),
                subtitle: Obx(() {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5,),
                    child: TextField(
                      controller: listController.usernameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(

                        hintText: listController.username.value,
                        hintStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),

                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),)
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
