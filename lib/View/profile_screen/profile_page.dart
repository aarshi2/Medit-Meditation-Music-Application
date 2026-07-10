import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medit_app/View/library_screen/controller_palylist.dart';
import 'package:medit_app/View/library_screen/your_palylist.dart';
import 'package:medit_app/View/profile_screen/controller_profile.dart';
import 'package:medit_app/View/signup_screen/controller_signup.dart';
import 'package:medit_app/resources/color.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ControllerPlaylist listController = Get.put(ControllerPlaylist());
  final YourPalylist yourpalylist = Get.put(YourPalylist());
  final SignupController signupController = Get.put(SignupController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    signupController.fetchPlaylist();
    yourpalylist.fetchPlaylist();

  }
  @override
  Widget build(BuildContext context) {

    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: GradientDecoration.getBackground(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return ListTile(
                  title: Text(
                    listController.username.value.isNotEmpty
                        ? listController.username.value
                        : 'Undefined name',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text(
                    listController.email.value.isNotEmpty
                        ? listController.email.value
                        : 'Undefined email',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  leading: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.black38,
                    child: Center(
                      child: Text(
                        listController.username.value.isNotEmpty
                            ? listController.username.value[0]
                            : 'U',
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              const Divider(
                height: 18,
                color: Colors.white,
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => const EditProfileBottomSheet(),
                  );
                },
                child: Container(
                  width: 90,
                  height: 30,
                  decoration: BoxDecoration(

                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "Edit",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Your PlayList",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 20)),
              const SizedBox(height: 10),
              Expanded(
                child: yourpalylist.playlists.isEmpty
                    ? Center(
                  child: Text(
                    "No playlists created yet.",
                    style: TextStyle(color: Colors.white),
                  ),
                )
               : Obx(
                      () => ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: yourpalylist.playlists.length,
                    itemBuilder: (context, index) {
                      // Extract the key (playlist name) from the map
                      String playlistName =
                          yourpalylist.playlists[index].keys.first;
                      //  print("print palylist.......${yourpalylist.playlist}");
                      var playlistSongs = signupController.playlist[index]
                      [playlistName][0]["songImg"] ??[];
                      // print(playlistSongs);
                      String? firstSongImg;
                      if (playlistSongs.isNotEmpty) {
                        firstSongImg = playlistSongs;
                      }
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8, top: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: firstSongImg != null
                                ? NetworkImage(firstSongImg)
                                : null,
                            // Use the first song's image if available
                            child: firstSongImg == null
                                ? const Icon(Icons.music_note,
                                color: Colors.white)
                                : null, // Show a default icon if no image is available
                          ),
                          title: Text(
                            playlistName,
                            style: const TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),


                          onTap: () async {

                              Get.to(const YourPalyList());
                            }

                        ),
                      );
                    },
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
