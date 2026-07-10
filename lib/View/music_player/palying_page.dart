import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medit_app/View/music_player/controller_player.dart';

class PalyingPage extends StatelessWidget {
  const PalyingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PlayerController playerController = Get.put(PlayerController());
    return Container(
      width: double.maxFinite,
      height: 70,
      decoration: const BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 70,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(playerController
                          .modelList[playerController.playerIndex.value]
                          .songImg),
                      fit: BoxFit.fitWidth)),
            ),
          ),
          Expanded(
            child: Text(
              playerController
                  .modelList[playerController.playerIndex.value].songName,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
          IconButton(
              onPressed: () {
                playerController.decreaseIndex();

                playerController.setupAudioPlayer(playerController
                    .modelList[playerController.playerIndex.value]);
              },
              icon: const Icon(
                Icons.skip_previous,
                size: 35,
                color: Colors.white,
              )),
          playerController.playbackControlButton(64.0),
          IconButton(
              onPressed: () {
                playerController.increaseIndex();
                playerController.setupAudioPlayer(playerController
                    .modelList[playerController.playerIndex.value]);
              },
              icon: const Icon(
                Icons.skip_next,
                size: 35,
                color: Colors.white,
              )),
            IconButton(onPressed: () {
            playerController.isplayupdet(false);
            print(playerController.isplay);
           }, icon: const Icon(Icons.cancel,color: Colors.white,))
        ],
      ),
    );
  }
}
