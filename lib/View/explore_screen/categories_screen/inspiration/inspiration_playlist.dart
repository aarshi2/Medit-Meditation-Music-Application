import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medit_app/View/explore_screen/categories_screen/inspiration/inspiration_controller.dart';
import 'package:medit_app/View/home_page/song_controller.dart';
import 'package:medit_app/View/music_player/controller_player.dart';
import 'package:medit_app/View/music_player/player_page.dart';
import 'package:medit_app/resources/color.dart';

class InspirationPlaylist extends StatefulWidget {
  const InspirationPlaylist({super.key});

  @override
  State<InspirationPlaylist> createState() => _InspirationPlaylistState();
}

class _InspirationPlaylistState extends State<InspirationPlaylist> {
  final MyController songController = Get.put(MyController());
  final PlayerController playerController = Get.put(PlayerController());
  final InspirationController inspirationController = Get.put(InspirationController());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: GradientDecoration.getBackground(),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          title: const Center(child: Text("Inspiration",style: TextStyle(color: Colors.white),)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(
                      () => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: inspirationController.palyModelList.length,
                    itemBuilder: (context, index) {
                      final song = inspirationController.palyModelList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 15),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
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
                            style: const TextStyle(color: Colors.white70,),
                          ),
                          trailing: IconButton(onPressed: () {
                            Get.to( MusicPlayer(ModelList: inspirationController.palyModelList,), arguments: index);
                            playerController.setupAudioPlayer(inspirationController.palyModelList[index]);

                          }, icon: const Icon(Icons.play_arrow,color: Colors.white,)),

                        ),
                      );
                    },
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
