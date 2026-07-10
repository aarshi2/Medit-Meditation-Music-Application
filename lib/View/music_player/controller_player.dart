import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class PlayerController extends GetxController {
  final player = AudioPlayer();

  // final FlutterSoundRecorder recorder = FlutterSoundRecorder();
  RxBool isTranscribing = false.obs;
  RxString transcription = ''.obs;
  var lastIndex = 0.obs;
  var playerIndex = 0.obs;
  RxBool isplay = false.obs;
  var modelList;
  RxBool next = false.obs;

  void isplayupdet(bool value) {
    isplay.value == value;
    update();
  }

  // Method to update the player index
  void increaseIndex() {
    if (playerIndex.value != lastIndex.value) {
      playerIndex.value++;
      update();
    } else {
      playerIndex.value = 0;
      update();
    }
  }

  void decreaseIndex() {
    if (playerIndex.value > 0) {
      playerIndex.value--;
      update();
    } else {
      playerIndex.value = lastIndex.value;
      update();
    }
  }

  Future<void> setupAudioPlayer(song) async {
    await player.setAudioSource(AudioSource.uri(
      Uri.parse(song.songUrl),
      tag: MediaItem(
        id: song.id,
        album: song.songName,
        title: "Medit",
        artist: song.artist,
        artUri: Uri.parse(song.songImg),
      ),
    ));
    player.play();
  }

  @override
  void onInit() {
    super.onInit();
    player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        if (next.value == false) {
          playNextSong();
          next.value = true;
        }
        update();
      }
    });
  }

  Future<void> playNextSong() async {
    if (kDebugMode) {
      print("Playing next song");
    }

    increaseIndex();
    await setupAudioPlayer(modelList[playerIndex.value]);
    next.value = false;
  }

  Widget progessBar() {
    return StreamBuilder<Duration?>(
      stream: player.positionStream,
      builder: (context, snapshot) {
        return ProgressBar(
          progress: snapshot.data ?? Duration.zero,
          baseBarColor: Colors.white,
          buffered: player.bufferedPosition,
          total: player.duration ?? Duration.zero,
          onSeek: (duration) {
            player.seek(duration);
          },
          bufferedBarColor: Colors.white,
          thumbGlowColor: Colors.white,
          progressBarColor: Colors.deepPurple,
          thumbColor: Colors.deepPurple,
          timeLabelTextStyle: const TextStyle(color: Colors.white),
        );
      },
    );
  }

  Widget playbackControlButton(size) {
    return StreamBuilder<PlayerState>(
        stream: player.playerStateStream,
        builder: (context, snapshot) {
          final processingState = snapshot.data?.processingState;
          final playing = snapshot.data?.playing;
          if (processingState == ProcessingState.loading ||
              processingState == ProcessingState.buffering) {
            return Container(
              margin: const EdgeInsets.all(8.0),
              width: 64,
              height: 64,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            );
          } else if (playing != true) {
            return IconButton(
              icon: const Icon(
                Icons.play_circle_fill,
                color: Colors.white,
              ),
              iconSize: size,
              onPressed: player.play,
            );
          } else if (processingState != ProcessingState.completed) {
            return IconButton(
              icon: const Icon(
                Icons.pause_circle,
                color: Colors.white,
              ),
              iconSize: size,
              onPressed: player.pause,
            );
          } else {
            return IconButton(
                icon: const Icon(
                  Icons.replay_circle_filled,
                  color: Colors.white,
                ),
                iconSize: size,
                onPressed: () => player.seek(Duration.zero));
          }
        });
  }

  // ignore: non_constant_identifier_names
  Widget SpeedButtons() {
    var speed = '1';
    return Column(mainAxisSize: MainAxisSize.min, children: [
      StreamBuilder(
          stream: player.speedStream,
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Text(
                    "Speed",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.speed,
                          color: Colors.black,
                        ),
                        Slider(
                            thumbColor: Colors.deepPurple,
                            activeColor: Colors.deepPurple,
                            inactiveColor: Colors.black,
                            min: 1,
                            max: 2,
                            value: snapshot.data ?? 1,
                            divisions: 4,
                            onChanged: (value) async {
                              await player.setSpeed(value);
                              speed = value.toString();
                            }),
                        Text("${speed}x")
                      ]),
                ],
              ),
            );
          }),
    ]);
  }

  // ignore: non_constant_identifier_names
  Widget VolumeButtons() {
    var volume = 0;
    return Column(mainAxisSize: MainAxisSize.min, children: [
      StreamBuilder(
          stream: player.volumeStream,
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text(
                    "Volume",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.volume_up,
                          color: Colors.black,
                        ),
                        Slider(
                            thumbColor: Colors.deepPurple,
                            activeColor: Colors.deepPurple,
                            inactiveColor: Colors.black,
                            min: 0,
                            max: 100,
                            value: snapshot.data ?? 1,
                            divisions: 4,
                            onChanged: (value) async {
                              await player.setVolume(value);
                              volume = value.toInt();
                            }),
                        Text("$volume")
                      ]),
                ],
              ),
            );
          }),
    ]);
  }

  String lyrics = "om";
}
