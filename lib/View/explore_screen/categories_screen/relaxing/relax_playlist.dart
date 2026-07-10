import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medit_app/View/explore_screen/categories_screen/relaxing/relax_controller.dart';
import 'package:medit_app/View/home_page/song_controller.dart';
import 'package:medit_app/View/music_player/controller_player.dart';
import 'package:medit_app/View/music_player/player_page.dart';
import 'package:medit_app/resources/color.dart';

class RelaxPlaylist extends StatefulWidget {
  const RelaxPlaylist({super.key});

  @override
  State<RelaxPlaylist> createState() => _RelaxPlaylistState();
}

class _RelaxPlaylistState extends State<RelaxPlaylist> {
  final MyController songController = Get.put(MyController());
  final PlayerController playerController = Get.put(PlayerController());
  final RelaxController relaxController = Get.put(RelaxController());
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
          title: const Center(child: Text("Relaxing",style: TextStyle(color: Colors.white),)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(
                      () => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: relaxController.palyModelList.length,
                    itemBuilder: (context, index) {
                      final song = relaxController.palyModelList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 15),
                        child: ListTile(
                          onTap: () {
                            Get.to( MusicPlayer(ModelList: relaxController.palyModelList,), arguments: index);
                            playerController.setupAudioPlayer(relaxController.palyModelList[index]);
                          },
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
