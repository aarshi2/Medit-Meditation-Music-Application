import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medit_app/View/home_page/song_controller.dart';
import 'package:medit_app/View/library_screen/controller_palylist.dart';
import 'package:medit_app/View/library_screen/your_palylist.dart';
import 'package:medit_app/View/signup_screen/controller_signup.dart';
import 'package:medit_app/resources/color.dart';
import 'controller_library.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  final ControllerLibrary playlistController = Get.put(ControllerLibrary());
  final MyController songController = Get.put(MyController());
  final SignupController signupController = Get.put(SignupController());
  final YourPalylist yourpalylist = Get.put(YourPalylist());

  @override
  void initStaate() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    playlistController.fetchSongsFromPlaylist();
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: GradientDecoration.getBackground(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            'Playlist',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Obx(
          () => ListView.builder(
            itemCount: signupController.playlist.length,
            itemBuilder: (context, index) {
              // Extract the key (playlist name) from the map
              String playlistName = signupController.playlist[index].keys.first;
              return ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.deepPurple,
                  child: Text(playlistName[0].toUpperCase()),
                ),
                title: Text(
                  playlistName.toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "song ${yourpalylist.songList}",
                  style: const TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        yourpalylist.deletePlaylist(index);
                      });
                    },
                    icon: const Icon(
                      Icons.delete_rounded,
                      color: Colors.white,
                    )),
                onTap: () async {
                  yourpalylist.fetchPlaylistModel(playlistName, index);
                  if (kDebugMode) {
                    print("print data ${yourpalylist.playlistModel}");
                  }
                  Get.to(const YourPalyList());
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
