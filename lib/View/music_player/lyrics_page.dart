import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medit_app/View/music_player/share_page.dart';

import 'controller_player.dart';

class LyricsPage extends StatefulWidget {
  const LyricsPage({super.key});

  @override
  State<LyricsPage> createState() => _LyricsPageState();
}

class _LyricsPageState extends State<LyricsPage> {
  final PlayerController playerController = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 10,
                child: Row(
                  children: [
                    Expanded(
                        flex: 25,
                        child: IconButton(
                          onPressed: () {
                           // Get.to(const MusicPlayer());
                          },
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                          ),
                        )),
                    const Expanded(
                        flex: 50,
                        child: Center(
                          child: Text(
                            "song name",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        )),
                    Expanded(
                        flex: 25,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        )),
                  ],
                )),
            Expanded(
                flex: 70,
                child: ListView(
                  children: [
                    Center(
                        child: Text(
                      playerController.lyrics,
                      style: const TextStyle(color: Colors.white),
                    ))
                  ],
                )),
            Expanded(
              flex: 20,
              child: Column(
                children: [
                  Expanded(
                    flex: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: playerController.progessBar(),
                    ),
                  ),
                  Expanded(
                      flex: 70,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          Expanded(child: Container()),
                          Expanded(child: playerController.playbackControlButton(64.0)),
                          Expanded(child: IconButton(onPressed: () {
                          Get.to(ShareScreen(lyrics: playerController.lyrics,));
                          }, icon: const Icon(Icons.share,color: Colors.white,size: 25,)))
                        ],),
                      ))
                ],
              ),
            )
          ]
        ),
      ),
    );
  }
}
