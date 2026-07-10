import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medit_app/View/music_player/controller_player.dart';
import 'package:medit_app/View/music_player/player_page.dart';
import 'package:medit_app/resources/color.dart';
import 'controller_fav.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  final ControllerFav favController = Get.put(ControllerFav());
  final PlayerController playerController = Get.put(PlayerController());

  @override
  void initState() {
    super.initState();
    favController.fetchFavModel();
  }

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
            "Favorite Songs",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Obx(
              () {
            if (favController.favList.isEmpty) {
              return const Center(
                child: Text(
                  "No Favorite Songs Yet.",
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: favController.favList.length,
                itemBuilder: (context, index) {
                  final song = favController.favList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListTile(
                      onTap: () {
                        Get.to(
                          MusicPlayer(
                            ModelList: favController.favList,
                          ),
                          arguments: index,
                        );
                        playerController.setupAudioPlayer(
                          favController.favList[index],
                        );
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
                              song.songImg ?? '', // Handle null case
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(
                        song.songName ?? 'Unknown', // Handle null case
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        song.artist ?? 'Unknown', // Handle null case
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          favController.removeSongFromFav(song.playlistId ?? '');
                        },
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
