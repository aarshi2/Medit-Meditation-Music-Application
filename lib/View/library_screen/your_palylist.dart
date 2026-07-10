import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:medit_app/View/library_screen/controller_palylist.dart';
import 'package:medit_app/View/music_player/controller_player.dart';
import 'package:medit_app/View/music_player/player_page.dart';
import 'package:medit_app/resources/color.dart';

class YourPalyList extends StatefulWidget {
  const YourPalyList({super.key});

  @override
  State<YourPalyList> createState() => _YourPalylistState();
}

class _YourPalylistState extends State<YourPalyList> {
  final YourPalylist yourpalylist = Get.put(YourPalylist());
  final PlayerController playerController = Get.put(PlayerController());
  bool selectionMode = false;
  Set<int> selectedIndexes = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: GradientDecoration.getBackground(),
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            "Palylist",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showMenu(
                  context: context,
                  position: const RelativeRect.fromLTRB(70, 70, 0, 0),
                  // Change this to position the popup menu
                  items: [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Text("Option 1"),
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text("Option 2"),
                    ),
                    const PopupMenuItem<int>(
                      value: 2,
                      child: Text("Option 3"),
                    ),
                  ],
                ).then((value) {
                  // Handle the selected option here
                  if (value != null) {
                    switch (value) {
                      case 0:
                        // Do something for Option 1
                        break;
                      case 1:
                        // Do something for Option 2
                        break;
                      case 2:
                        // Do something for Option 3
                        break;
                    }
                  }
                });
              },
              icon: const Icon(Icons.more_vert, color: Colors.white),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        body: Obx(
          () => ListView.builder(
            itemCount: yourpalylist.playlistModel.length,
            itemBuilder: (context, index) {
              final song = yourpalylist.playlistModel[index];
              return Padding(
                padding: const EdgeInsets.all(8),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    Get.to(
                        MusicPlayer(
                          ModelList: yourpalylist.playlistModel,
                        ),
                        arguments: index);
                    playerController
                        .setupAudioPlayer(yourpalylist.playlistModel[index]);
                  },
                  leading: Container(
                    width: 80,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(
                          song.songImg,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    song.songName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    song.artist,
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                      if(yourpalylist.playlistModel.length > 1){
                        yourpalylist.playlistModel;
                        yourpalylist.deleteSongFromPlaylist(song.id);
                        yourpalylist.playlistModel;
                      }else{
                        Fluttertoast.showToast(
                          msg: "you don't delete last song",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );

                      }
                        //   yourpalylist.deleteSongFromPlaylist(song.id);
                        /*  Get.to( MusicPlayer(modelList: yourpalylist.playlistModel,), arguments: index);
                        playerController.setupAudioPlayer(yourpalylist.ModelList[index]);*/
                      },
                      icon: const Icon(
                        Icons.delete_rounded,
                        color: Colors.white,
                      )),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
